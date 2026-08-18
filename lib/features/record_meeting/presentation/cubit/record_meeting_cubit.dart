import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:ffmpeg_kit_flutter_new_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_audio/return_code.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../config/record_meeting_audio_quality.dart';

part 'record_meeting_state.dart';

@pragma('vm:entry-point')
void recordMeetingForegroundTaskCallback() {
  FlutterForegroundTask.setTaskHandler(RecordMeetingForegroundTaskHandler());
}

class RecordMeetingForegroundTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {}
}

class RecordMeetingCubit extends Cubit<RecordMeetingState>
    with WidgetsBindingObserver {
  RecordMeetingCubit() : super(const RecordMeetingState()) {
    WidgetsBinding.instance.addObserver(this);
    _initForegroundService();
  }

  final AudioRecorder _recorder = AudioRecorder();
  String? _activeRecordPath;

  Future<void> startRecord() async {
    if (await _recorder.isRecording()) {
      return;
    }

    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      emit(const RecordMeetingState());
      return;
    }

    try {
      final recordPath = await _createRecordPath();
      await _startRecordingProtection();
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: recordPath,
      );

      _activeRecordPath = recordPath;
      emit(StartRecordMeeting(recordPath: recordPath));
    } catch (_) {
      await _stopRecordingProtection();
      emit(const RecordMeetingState());
    }
  }

  Future<void> pauseRecord() async {
    if (!await _recorder.isRecording()) {
      return;
    }

    await _recorder.pause();
    emit(const PauseRecordMeeting());
  }

  Future<void> resumeRecord() async {
    await _recorder.resume();
    emit(const ResumeRecordMeeting());
  }

  Future<void> finishRecord() async {
    if (state is FinishingRecordState) {
      return;
    }

    emit(FinishingRecordState(recordPath: _activeRecordPath));
    final recordPath = await _safeStopRecorder();
    final mp3Path = await _convertRecordToMp3(recordPath);
    await _stopRecordingProtection();
    _activeRecordPath = null;
    if (mp3Path == null) {
      emit(
        const ErrorRecordMeetingState(
          message: 'Could not save the meeting record. Please try again.',
        ),
      );
    } else {
      emit(FinishRecordMeeting(recordPath: mp3Path));
    }
    emit(const RecordMeetingState());
  }

  Future<void> _startRecordingProtection() async {
    await WakelockPlus.enable();

    if (Platform.isAndroid) {
      await _requestAndroidForegroundPermissions();

      if (await FlutterForegroundTask.isRunningService) {
        await FlutterForegroundTask.updateService(
          notificationTitle: 'Recording meeting',
          notificationText: 'Meeting recording is still running.',
        );
        return;
      }

      final result = await FlutterForegroundTask.startService(
        serviceId: 1001,
        serviceTypes: const [ForegroundServiceTypes.microphone],
        notificationTitle: 'Recording meeting',
        notificationText: 'Meeting recording is still running.',
        notificationInitialRoute: '/record-meeting',
        callback: recordMeetingForegroundTaskCallback,
      );

      if (result is ServiceRequestFailure) {
        await WakelockPlus.disable();
        throw result.error;
      }
    }
  }

  Future<void> _stopRecordingProtection() async {
    if (Platform.isAndroid && await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
    await WakelockPlus.disable();
  }

  Future<void> _requestAndroidForegroundPermissions() async {
    final notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }
  }

  void _initForegroundService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'record_meeting_service',
        channelName: 'Meeting Recording',
        channelDescription:
            'Keeps meeting recording active while the phone is locked.',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(30000),
        allowWakeLock: true,
        allowWifiLock: true,
        allowAutoRestart: true,
        stopWithTask: false,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isRecordingState =
        this.state is StartRecordMeeting ||
        this.state is PauseRecordMeeting ||
        this.state is ResumeRecordMeeting ||
        this.state is FinishingRecordState;

    if (!isRecordingState) {
      return;
    }

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.resumed) {
      WakelockPlus.enable();
      if (Platform.isAndroid) {
        FlutterForegroundTask.updateService(
          notificationTitle: 'Recording meeting',
          notificationText: 'Meeting recording is still running.',
        );
      }
    }
  }

  Future<String> _createRecordPath() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final recordsDirectory = Directory(
      '${documentsDirectory.path}${Platform.pathSeparator}record_meetings',
    );

    if (!recordsDirectory.existsSync()) {
      recordsDirectory.createSync(recursive: true);
    }

    final fileDateTime = _formatRecordFileDateTime(DateTime.now());
    return '${recordsDirectory.path}${Platform.pathSeparator}'
        'meeting_$fileDateTime.m4a';
  }

  String _formatRecordFileDateTime(DateTime dateTime) {
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');

    return '$year-$month-${day}_$hour-$minute-$second';
  }

  Future<String?> _convertRecordToMp3(String? sourcePath) async {
    if (sourcePath == null || sourcePath.isEmpty) {
      return null;
    }

    final sourceFile = File(sourcePath);
    if (!sourceFile.existsSync()) {
      return null;
    }

    final mp3Path = sourcePath.replaceAll(RegExp(r'\.[^.]+$'), '.mp3');
    final command = [
      '-y',
      '-i',
      _quotePath(sourcePath),
      '-vn',
      '-codec:a',
      'libmp3lame',
      ...RecordMeetingAudioConfig.defaultQuality.ffmpegAudioArguments,
      _quotePath(mp3Path),
    ].join(' ');

    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      await sourceFile.delete();
      log('MP3 record saved at: $mp3Path', name: 'RecordMeetingCubit');
      return mp3Path;
    }

    log(
      'MP3 conversion failed. Temporary record remains at: $sourcePath',
      name: 'RecordMeetingCubit',
    );
    return null;
  }

  String _quotePath(String path) {
    return "'${path.replaceAll("'", "'\\''")}'";
  }

  Future<String?> _safeStopRecorder() async {
    try {
      return _recorder.stop();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> close() async {
    WidgetsBinding.instance.removeObserver(this);
    if (_activeRecordPath != null) {
      await _safeStopRecorder();
      await _stopRecordingProtection();
      _activeRecordPath = null;
    }
    await _recorder.dispose();
    return super.close();
  }
}

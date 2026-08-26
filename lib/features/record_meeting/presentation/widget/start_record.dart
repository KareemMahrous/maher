import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import 'sound_indicator.dart';

class StartRecord extends StatelessWidget {
  const StartRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordMeetingCubit, RecordMeetingState>(
      builder: (context, state) {
        final isActive =
            state is StartRecordMeeting ||
            state is PauseRecordMeeting ||
            state is ResumeRecordMeeting;
        final isFinishing = state is FinishingRecordState;
        final isPaused = state is PauseRecordMeeting;
        final showSoundIndicator = isActive && !isPaused;
        final elapsedDuration = _elapsedDurationFromState(state);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: isActive || isFinishing
                  ? null
                  : context.read<RecordMeetingCubit>().startRecord,
              customBorder: const CircleBorder(),
              child: Container(
                width: 180,
                height: 180,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showSoundIndicator)
                      const SoundIndicator()
                    else
                      Icon(
                        isPaused ? Icons.pause : Icons.mic,
                        color: Colors.white,
                        size: isActive ? 64 : 72,
                      ),
                    if (elapsedDuration != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _formatDuration(elapsedDuration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (isActive || isFinishing) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.filled(
                    onPressed: isFinishing
                        ? null
                        : () => _confirmDiscardRecord(context),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      disabledForegroundColor: Colors.grey.shade600,
                    ),
                    tooltip: 'recordMeeting.actions.close'.tr(),
                    icon: const Icon(Icons.close),
                  ),
                  const SizedBox(width: 12),
                  IconButton.filled(
                    onPressed: isFinishing
                        ? null
                        : context.read<RecordMeetingCubit>().finishRecord,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      disabledForegroundColor: Colors.grey.shade600,
                    ),
                    tooltip: 'recordMeeting.actions.finish'.tr(),
                    icon: const Icon(Icons.stop),
                  ),
                  const SizedBox(width: 12),
                  IconButton.filled(
                    onPressed: isFinishing
                        ? null
                        : isPaused
                        ? context.read<RecordMeetingCubit>().resumeRecord
                        : context.read<RecordMeetingCubit>().pauseRecord,
                    style: IconButton.styleFrom(
                      backgroundColor: isPaused ? Colors.green : Colors.orange,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      disabledForegroundColor: Colors.grey.shade600,
                    ),
                    tooltip: isPaused
                        ? 'recordMeeting.actions.resume'.tr()
                        : 'recordMeeting.actions.pause'.tr(),
                    icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  Duration? _elapsedDurationFromState(RecordMeetingState state) {
    if (state is StartRecordMeeting) {
      return state.elapsedDuration;
    }
    if (state is PauseRecordMeeting) {
      return state.elapsedDuration;
    }
    if (state is ResumeRecordMeeting) {
      return state.elapsedDuration;
    }
    return null;
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  Future<void> _confirmDiscardRecord(BuildContext context) async {
    final cubit = context.read<RecordMeetingCubit>();
    final shouldDiscard = await showAdaptiveDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog.adaptive(
          title: Text('recordMeeting.dialog.closeTitle'.tr()),
          content: Text('recordMeeting.dialog.closeMessage'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text('recordMeeting.dialog.no'.tr()),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text('recordMeeting.dialog.yesClose'.tr()),
            ),
          ],
        );
      },
    );

    if (shouldDiscard ?? false) {
      await cubit.discardRecord();
    }
  }
}

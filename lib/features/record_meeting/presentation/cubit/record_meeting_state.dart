part of 'record_meeting_cubit.dart';

class RecordMeetingState extends Equatable {
  const RecordMeetingState();

  @override
  List<Object?> get props => [];
}

class StartRecordMeeting extends RecordMeetingState {
  const StartRecordMeeting({
    required this.recordPath,
    required this.elapsedDuration,
  });

  final String recordPath;
  final Duration elapsedDuration;

  @override
  List<Object?> get props => [recordPath, elapsedDuration];
}

class PauseRecordMeeting extends RecordMeetingState {
  const PauseRecordMeeting({required this.elapsedDuration});

  final Duration elapsedDuration;

  @override
  List<Object?> get props => [elapsedDuration];
}

class ResumeRecordMeeting extends RecordMeetingState {
  const ResumeRecordMeeting({required this.elapsedDuration});

  final Duration elapsedDuration;

  @override
  List<Object?> get props => [elapsedDuration];
}

class FinishingRecordState extends RecordMeetingState {
  const FinishingRecordState({this.recordPath});

  final String? recordPath;

  @override
  List<Object?> get props => [recordPath];
}

class FinishRecordMeeting extends RecordMeetingState {
  const FinishRecordMeeting({
    required this.recordPath,
    required this.elapsedDuration,
    this.messageKey = 'recordMeeting.snackbar.saveSuccess',
  });

  final String? recordPath;
  final Duration elapsedDuration;
  final String messageKey;

  @override
  List<Object?> get props => [recordPath, elapsedDuration, messageKey];
}

class ErrorRecordMeetingState extends RecordMeetingState {
  const ErrorRecordMeetingState({required this.messageKey});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}

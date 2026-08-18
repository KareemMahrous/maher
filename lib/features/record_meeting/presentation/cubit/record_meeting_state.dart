part of 'record_meeting_cubit.dart';

class RecordMeetingState extends Equatable {
  const RecordMeetingState();

  @override
  List<Object?> get props => [];
}

class StartRecordMeeting extends RecordMeetingState {
  const StartRecordMeeting({required this.recordPath});

  final String recordPath;

  @override
  List<Object?> get props => [recordPath];
}

class PauseRecordMeeting extends RecordMeetingState {
  const PauseRecordMeeting();
}

class ResumeRecordMeeting extends RecordMeetingState {
  const ResumeRecordMeeting();
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
    this.message = 'Meeting record saved successfully.',
  });

  final String? recordPath;
  final String message;

  @override
  List<Object?> get props => [recordPath, message];
}

class ErrorRecordMeetingState extends RecordMeetingState {
  const ErrorRecordMeetingState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

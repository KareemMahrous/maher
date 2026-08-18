part of 'pick_file_cubit.dart';

sealed class PickFileState extends Equatable {}

final class PickFileStateInitial extends PickFileState {
  @override
  List<Object> get props => [];
}

final class PickFileStateLoading extends PickFileState {
  @override
  List<Object> get props => [];
}

final class PickFileStateSuccess extends PickFileState {
  final File? pickedFile;
  final String? pickedFilePath;
  final String message;
  final String fileName;

  PickFileStateSuccess({
    required this.pickedFile,
    required this.pickedFilePath,
    required this.message,
    required this.fileName,
  });

  @override
  List<Object> get props => [];
}

final class PickFileStateError extends PickFileState {
  final String error;
  final bool showToast;

  PickFileStateError(this.error, this.showToast);

  @override
  List<Object> get props => [];
}

final class PickFileStateCanceled extends PickFileState {
  @override
  List<Object> get props => [];
}

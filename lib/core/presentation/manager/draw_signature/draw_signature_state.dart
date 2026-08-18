part of 'draw_signature_cubit.dart';

sealed class DrawSignatureState extends Equatable {}

final class DrawSignatureStateInitial extends DrawSignatureState {
  @override
  List<Object> get props => [];
}

final class DrawSignatureStateLoading extends DrawSignatureState {
  @override
  List<Object> get props => [];
}

final class DrawSignatureStateSuccess extends DrawSignatureState {
  final File? drawFile;
  final String? drawFilePath;
  final String? drawFileBase64;
  final String message;
  final String fileName;
  final bool ?isHandDrawing;

  DrawSignatureStateSuccess({
    required this.drawFile,
    required this.drawFilePath,
    required this.drawFileBase64,
    required this.message,
    required this.fileName,
    this.isHandDrawing = false,
  });

  @override
  List<Object> get props => [];
}

final class DrawSignatureStateError extends DrawSignatureState {
  final String error;

  DrawSignatureStateError(this.error);

  @override
  List<Object> get props => [];
}

final class ChangeEnableDrawingValueState extends DrawSignatureState {
  @override
  List<Object> get props => [];
}

final class DeleteDrawSignatureState extends DrawSignatureState {
  @override
  List<Object> get props => [];
}

final class UndoDrawSignatureState extends DrawSignatureState {
  @override
  List<Object> get props => [];
}

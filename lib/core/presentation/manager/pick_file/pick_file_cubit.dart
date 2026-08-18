import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

import '../../../core.dart';

part 'pick_file_state.dart';

class PickFileCubit extends Cubit<PickFileState> {
  PickFileCubit() : super(PickFileStateInitial());

  FilePickerResult? result;

  File? pickedFile;

  emitError({bool showToast = true}) =>
      emit(PickFileStateError(LocaleKeys.fieldIsRequired.tr(), showToast));

  deleteFiles() {
    result = null;
    pickedFile = null;
    emit(PickFileStateInitial());
  }

  putFile(File? pickedFileValue) {
    if (pickedFileValue == null) {
      return;
    }
    pickedFile = pickedFileValue;
    emit(
      PickFileStateSuccess(
        pickedFile: pickedFileValue,
        message: LocaleKeys.filePickSuccess.tr(),
        fileName: p.basename(pickedFileValue.path),
        pickedFilePath: pickedFileValue.path,
      ),
    );
  }

  pickFile({
    required List<PickFileType> fileTypes,
    int? maximumFileSize,
    bool haveMaximumFileSize = false,
  }) async {
    removePickedFile();
    final int maxFileSizeInBytes =
        (maximumFileSize ?? 5) * (1024 * 1024); // 5 MB
    emit(PickFileStateLoading());
    try {
      final extensions = fileTypes.map((e) => e.extension).toList();
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: extensions,
      );
      if (result != null && result!.files.single.path != null) {
        final fileBytes = result!.files.single.size;
        if (fileBytes > maxFileSizeInBytes && haveMaximumFileSize == true) {
          emit(
            PickFileStateError(
              "fileIsTooLarge".tr(
                namedArgs: {'size': '${maximumFileSize ?? 5}'},
              ),
              true,
            ),
          );
          return;
        }
        pickedFile = File(result!.files.single.path!);
        emit(
          PickFileStateSuccess(
            pickedFile: pickedFile,
            message: LocaleKeys.filePickSuccess.tr(),
            fileName: result!.files.single.name,
            pickedFilePath: result!.files.single.path!,
          ),
        );
      } else {
        emit(PickFileStateCanceled());
      }
    } catch (e) {
      emit(PickFileStateError(e.toString(), true));
    }
  }

  removePickedFile({bool haveEmit = true}) {
    result = null;
    pickedFile = null;
    if (haveEmit) {
      emit(PickFileStateInitial());
    }
  }
}

enum PickFileType { pdf, png, jpg, jpeg, svg }

extension AppFileTypeExtension on PickFileType {
  String get extension {
    switch (this) {
      case PickFileType.pdf:
        return 'attachment';
      case PickFileType.png:
        return 'png';
      case PickFileType.jpg:
        return 'jpg';
      case PickFileType.svg:
        return 'svg';
      case PickFileType.jpeg:
        return 'jpeg';
    }
  }
}

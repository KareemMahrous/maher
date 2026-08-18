import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:scribble/scribble.dart';

import '../../../core.dart';

part 'draw_signature_state.dart';

class DrawSignatureCubit extends Cubit<DrawSignatureState> {
  DrawSignatureCubit() : super(DrawSignatureStateInitial());

  emitError(String errorMessage) => emit(DrawSignatureStateError(errorMessage));

  late ScribbleNotifier notifier;
  bool enableDrawing = false;
  int hasDrawing = 0;
  File? imageFile;

  changeEnableDrawingValue({bool? forceEnableDrawing}) {
    enableDrawing = forceEnableDrawing ?? !enableDrawing;
    emit(ChangeEnableDrawingValueState());
  }

  deleteDrawing() {
    changeEnableDrawingValue(forceEnableDrawing: false);
    notifier.clear();
    imageFile = null;
    emit(DeleteDrawSignatureState());
  }

  undoDrawing() {
    changeEnableDrawingValue(forceEnableDrawing: false);
    notifier.undo();
    imageFile = null;
    emit(UndoDrawSignatureState());
  }

  @override
  Future<void> close() {
    notifier.dispose();
    return super.close();
  }

  initController() {
    notifier = ScribbleNotifier();
    notifier.addListener(onScribbleChanged);
  }

  void onScribbleChanged() {
    hasDrawing = notifier.currentSketch.lines.length;
    // if (hasDrawing == 0) {
    //   emitError(LocaleKeys.fieldIsRequired.tr());
    // }
    if (hasDrawing != 0) {
      emit(DrawSignatureStateInitial());
    }
  }

  String getUniqueFileName() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMdd_HHmmss');
    return 'image_${formatter.format(now)}.png';
  }

  extractImage({bool? isHandDrawing}) async {
    try {
      final byteData = await notifier.renderImage(
        pixelRatio: 2.0,
        format: ImageByteFormat.png,
      );
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${getUniqueFileName()}';
      imageFile = await File(imagePath).writeAsBytes(pngBytes);
      final finalPngBytes = await convertT8BitTransparentPng(imageFile!);
      emit(
        DrawSignatureStateSuccess(
          drawFile: imageFile,
          drawFileBase64: base64Encode(finalPngBytes),
          drawFilePath: imagePath,
          message: '',
          fileName: getUniqueFileName(),
          isHandDrawing: isHandDrawing,
        ),
      );
    } catch (e) {
      emitError('$e');
    }
  }

  // extractImage({bool? isHandDrawing}) async {
  //   try {
  //     final byteData = await notifier.renderImage(
  //       pixelRatio: 2.0,
  //       format: ImageByteFormat.png,
  //     );
  //
  //     final Uint8List pngBytes = byteData.buffer.asUint8List();
  //
  //     final directory = await getApplicationDocumentsDirectory();
  //     final imagePath = '${directory.path}/${getUniqueFileName()}';
  //
  //     imageFile = await File(imagePath).writeAsBytes(pngBytes);
  //
  //     final finalPngBytes =
  //     await convertT8BitTransparentPng(imageFile!);
  //
  //     // 🔥 overwrite بنفس الملف
  //     await imageFile!.writeAsBytes(finalPngBytes, flush: true);
  //
  //     emit(
  //       DrawSignatureStateSuccess(
  //         drawFile: imageFile,
  //         drawFileBase64: base64Encode(finalPngBytes),
  //         drawFilePath: imagePath,
  //         fileName: path.basename(imagePath),
  //         isHandDrawing: isHandDrawing,
  //         message: '',
  //       ),
  //     );
  //   } catch (e) {
  //     emitError(e.toString());
  //   }
  // }
}

Future<List<int>> convertT8BitTransparentPng(
  File inputFile, {
  bool makeWhiteTransparent = true,
  int whiteThreshold = 0,
}) async {
  final bytes = await inputFile.readAsBytes();
  final original = img.decodePng(bytes);
  if (original == null) {
    throw Exception('Could not decode PNG image.');
  }
  final converted = original.convert(format: img.Format.uint8, numChannels: 4);
  if (makeWhiteTransparent) {
    for (final p in converted) {
      if ((255 - p.r) <= whiteThreshold &&
          (255 - p.g) <= whiteThreshold &&
          (255 - p.b) <= whiteThreshold) {
        p.a = 0;
      }
    }
  }
  return img.encodePng(converted);
}

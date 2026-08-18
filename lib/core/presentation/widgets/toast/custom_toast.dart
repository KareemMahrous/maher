import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core.dart';

enum ToastType { success, error }

enum PopupDuration { short, long }

extension Toast on BuildContext {
  void showToast({
    String? description,
    Failure? failure,
    bool marginBottom = false,
    ToastType type = ToastType.success,
  }) {
    if (failure != null) {
      if (failure is ServerFailure) {
        if (kDebugMode) {
          print("message ${failure.message}");
        }
        description = failure.message;
      } else if (failure is NetworkFailure) {
        description =
            (failure.connectionTimeOut)
                ? LocaleKeys.connectionTimeOut.tr()
                : LocaleKeys.noInternetConnection.tr();
      }
    }
    if (description != null) {
      Fluttertoast.showToast(
        msg: description,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
            type == ToastType.success ? color.lightGreen : color.redColor,
        textColor: type == ToastType.success ? Colors.black : Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
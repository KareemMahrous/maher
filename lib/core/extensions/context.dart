import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../core.dart';

extension ContextExtension on BuildContext {
  AppColorScheme get color {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark ? AppColorDark() : AppColorLight();
  }

  /// [MediaQuery].of(context).size.width
  double get width => MediaQuery.sizeOf(this).width;

  /// [MediaQuery].of(context).size.height
  double get height => MediaQuery.sizeOf(this).height;

  double get shortestSide => MediaQuery.sizeOf(this).shortestSide;

  double get viewPaddingBottom => MediaQuery.of(this).viewPadding.bottom == 0
      ? 25
      : MediaQuery.of(this).viewPadding.bottom;

  double get longestSide => MediaQuery.sizeOf(this).longestSide;

  bool get phone => MediaQuery.sizeOf(this).shortestSide < 600;

  bool get ipad => MediaQuery.sizeOf(this).shortestSide > 600;

  bool get isPortrait =>
      MediaQuery.orientationOf(this) == Orientation.portrait ? true : false;

  Locale get getCurrentLocale =>
      e.EasyLocalization.of(this)?.currentLocale ?? const Locale('ar');

  AlignmentGeometry get getAlignment => getCurrentLocale == const Locale('ar')
      ? Alignment.centerRight
      : Alignment.centerLeft;

  /// Display a loading indicator [when] a specified condition is true.
  void showLoading({required bool when}) {
    if (when) {
      loaderOverlay.show();
    } else {
      loaderOverlay.hide();
    }
  }
}

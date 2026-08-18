import 'package:flutter/material.dart';

import '../../../helper/extensions/screen_spaces_extension.dart';

class AppInsets {
  AppInsets._();

  static const double _defaultScreenPadding = 16.0;

  static EdgeInsets defaultScreenALL(BuildContext context) =>
      EdgeInsets.all(_defaultScreenPadding.toRad());

  static EdgeInsets defaultScreenHorizontal(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: _defaultScreenPadding.toW(context));

  static EdgeInsets defaultScreenVertical(BuildContext context) =>
      EdgeInsets.symmetric(vertical: _defaultScreenPadding.toH(context));
}

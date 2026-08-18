import 'package:flutter/material.dart';

import '../../../helper/extensions/screen_spaces_extension.dart';

/// Creates Horizontal Spaces (X-Axis SizedBox)
class XSpace {
  XSpace._();

  /// width : 2.5
  static SizedBox tiny(BuildContext context) =>
      SizedBox(width: 2.5.toW(context));

  /// width : 5.0
  static SizedBox light(BuildContext context) =>
      SizedBox(width: 5.toW(context));

  /// width : 10.0
  static SizedBox normal(BuildContext context) =>
      SizedBox(width: 10.toW(context));

  /// width : 15.0
  static SizedBox hard(BuildContext context) =>
      SizedBox(width: 15.toW(context));

  /// width : 20.0
  static SizedBox extreme(BuildContext context) =>
      SizedBox(width: 20.toW(context));

  /// width : 25.0
  static SizedBox titan(BuildContext context) =>
      SizedBox(width: 25.toW(context));
}

/// Creates Vertical Spaces (Y-Axis SizedBox)
class YSpace {
  YSpace._();

  /// height : 2.5
  static SizedBox tiny(BuildContext context) =>
      SizedBox(height: 2.5.toH(context));

  /// height : 5.0
  static SizedBox light(BuildContext context) =>
      SizedBox(height: 5.toH(context));

  /// height : 10.0
  static SizedBox normal(BuildContext context) =>
      SizedBox(height: 10.toH(context));

  /// height : 15.0
  static SizedBox hard(BuildContext context) =>
      SizedBox(height: 15.toH(context));

  /// height : 20.0
  static SizedBox extreme(BuildContext context) =>
      SizedBox(height: 20.toH(context));

  /// height : 25.0
  static SizedBox titan(BuildContext context) =>
      SizedBox(height: 25.toH(context));
  static SizedBox erinYeager(BuildContext context) =>
      SizedBox(height: 50.toH(context));

  /// creates a Spacer (free space) in the Columns between 2 children
  static Spacer get spacer => const Spacer();
}

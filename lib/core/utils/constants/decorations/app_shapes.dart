import 'package:flutter/material.dart';

import '../../../helper/extensions/screen_spaces_extension.dart';

class AppShapes {
  AppShapes._();
  static ShapeBorder bottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.only(
      topStart: Radius.circular(20.0.toRad()),
      topEnd: Radius.circular(20.0.toRad()),
    ),
  );
  static ShapeBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0.toRad())),
  );
}

import 'package:flutter/material.dart';

class AppPhysics {
  AppPhysics._();
  static const alwaysScrollablePhysics = AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );
  static const bouncingPhysics = BouncingScrollPhysics();
  static const neverScrollable = NeverScrollableScrollPhysics();
}

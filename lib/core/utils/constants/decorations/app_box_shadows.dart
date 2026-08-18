import 'package:flutter/material.dart';

class AppBoxShadows {
  AppBoxShadows._();

  /// shadows on buttons as []
  static List<BoxShadow>? buttonShadow({bool isDark = false}) => [
    BoxShadow(
      // color: AppColors.get.primary.withValues(a:0.3),
      color: Colors.grey.withValues(alpha: .3),
      spreadRadius: 0.1,
      blurRadius: 8,
    ),
  ];

  static Widget circleshadow({required Widget child, bool isDark = false}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.1,
            blurRadius: 8,
            color: Colors.orange.withValues(alpha: 0.3),
          ),
        ],
      ),
      // shape: BoxShape.circle,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }
}

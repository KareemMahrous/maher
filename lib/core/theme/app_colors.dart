import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color lightPrimaryColor = Color(0xff006948);
  static const Color lightPrimaryFixedColor = Color(0xFFBBCABF);
  static const Color lightOnSecondaryContainerColor = Color(0xFF0B1823);
  static const Color lightSecondaryFixedColor = Color(0xff6B7870);
  static const Color lightSecondaryFixedDim = Color(0xff48544C);
  static const Color lightOnPrimaryVariantColor = Color(0xFFFFFFFF);
  static const Color lightSecondaryColor = Color(0xFFF4F7FC);
  static const Color lightSecondaryContainerColor = Color(0xFF00A651);
  static const Color lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color lightErrorColor = Color(0xFFB00020);
  static const Color lightOnPrimaryColor = Color(0xFFFFFFFF);
  static const Color lightOnSecondaryColor = Color(0xFF000000);
  static const Color lightOnSurfaceColor = Color(0xFF000000);
  static const Color lightPrimaryContainerColor = Color(0xFFF3F3F3);
  static const Color lightOnErrorColor = Color(0xFFFFFFFF);
  static const Color lightShadowColor = Color(0x1A3D3D3D);
  static const Color lightTertiaryFixedColor = Color(0xFFB65C5D);
  static const Color lightTertiaryFixedDimColor = Color(0xFFBF780A);
  static const Color lightSurfaceContainerColor = Color(0xFF000000);
  static const Color lightSurfaceContainerHighColor = Color(0xFFD6D6D6);
  static const Color lightSurfaceContainerLowColor = Color(0xFF68788F);
  static const Color lightOvertime = Color(0xFF8F91FF);
  static const Color lightUnselectedTabBarColor = Color(0xFFD9D9D9);
  static const Color lightSelectedTabBarColor = Color(0xFF000000);
  static const Color lightSplashColor = Color(0xFF0B1729);
  static const Color lighthBaigeColor = Color(0xFFE9F0EB);


  // Dark Theme Color
  static const Color darkPrimaryColor = Color(0xff006948);
  static const Color darkPrimaryFixedColor = Color(0xFF443540);
  static const Color darkOnPrimaryVariantColor = Color(0xFF000000);
  static const Color darkSecondaryColor = Color(0xFF0B0803);
  static const Color darkSecondaryContainerColor = Color(0xFF00A651);
  static const Color darkOnSecondaryContainerColor = Color(0xFFF4E7DC);
  static const Color darkSurfaceColor = Color(0xFF000000);
  static const Color darkErrorColor = Color(0xFFB00020);
  static const Color darkOnPrimaryColor = Color(0xFFFFFFFF);
  static const Color darkOnSecondaryColor = Color(0xFFFFFFFF);
  static const Color darkOnSurfaceColor = Color(0xFFFFFFFF);
  static const Color darkPrimaryContainerColor = Color(0xFF0C0C0C);
  static const Color darkOnErrorColor = Color(0xFF000000);
  static const Color darkShadowColor = Color(0x1AC2C2C2);
  static const Color darkSecondaryFixedColor = Color(0xFF94878F);
  static const Color darkSecondaryFixedDim = Color(0xFFB7ABB3);
  static const Color darkTertiaryFixedColor = Color(0xFFC8172B);
  static const Color darkTertiaryFixedDimColor = Color(0xFFFE9A00);
  static const Color darkSurfaceContainerColor = Color(0xFFFFFFFF);
  static const Color darkSurfaceContainerHighColor = Color(0xFF292929);
  static const Color darkSurfaceContainerLowColor = Color(0xFF00B1E6);
  static const Color darkOvertime = Color(0xFF5C5FFF);
  static const Color darkUnselectedTabBarColor = Color(0xFFD9D9D9);
  static const Color darkSelectedTabBarColor = Color(0xFF000000);
  static const Color darkSplashColor = Color(0xFFF4E8D6);
  static const Color darkhBaigeColor = Color(0xFFE9F0EB);
}

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color? overtime;
  final Color? unselectedTabBarColor;
  final Color? selectedTabBarColor;
  final Color? splashColor;
  final Color? hbaigeColor;

  const AppColorsExtension({
    required this.overtime,
    required this.unselectedTabBarColor,
    required this.selectedTabBarColor,
    required this.splashColor,
    required this.hbaigeColor,
  });

  @override
  AppColorsExtension copyWith({
    Color? overtime,
    Color? unselectedTabBarColor,
    Color? selectedTabBarColor,
    Color? splashColor,
  }) {
    return AppColorsExtension(
      overtime: overtime ?? this.overtime,
      unselectedTabBarColor:
          unselectedTabBarColor ?? this.unselectedTabBarColor,
      selectedTabBarColor: selectedTabBarColor ?? this.selectedTabBarColor,
      splashColor: splashColor ?? this.splashColor,
      hbaigeColor: hbaigeColor ?? this.hbaigeColor,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      overtime: Color.lerp(overtime, other.overtime, t),
      unselectedTabBarColor: Color.lerp(
        unselectedTabBarColor,
        other.unselectedTabBarColor,
        t,
      ),
      selectedTabBarColor: Color.lerp(
        selectedTabBarColor,
        other.selectedTabBarColor,
        t,
      ),
      splashColor: Color.lerp(splashColor, other.splashColor, t),
      hbaigeColor: Color.lerp(hbaigeColor, other.hbaigeColor, t),
    );
  }
}

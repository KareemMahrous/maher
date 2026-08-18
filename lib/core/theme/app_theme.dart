import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';
import 'theme.dart';

class AppTheme {
  /// Light Theme Builder
  static ThemeData lightTheme() {
    final base = ThemeData.light();
    final textTheme = lightTextTheme(base.textTheme.apply(fontFamily: 'Cairo'));

    return base.copyWith(
      colorScheme: const ColorScheme(
        secondaryFixed: AppColors.lightSecondaryFixedColor,
        primary: AppColors.lightPrimaryColor,
        onPrimary: AppColors.lightOnPrimaryColor,
        primaryFixed: AppColors.lightPrimaryFixedColor,
        onPrimaryFixed: AppColors.lightOnPrimaryVariantColor,
        secondary: AppColors.lightSecondaryColor,
        primaryContainer: AppColors.lightPrimaryContainerColor,
        secondaryContainer: AppColors.lightSecondaryContainerColor,
        onSecondaryContainer: AppColors.lightOnSecondaryContainerColor,
        surface: AppColors.lightSurfaceColor,
        secondaryFixedDim: AppColors.lightSecondaryFixedDim,
        error: AppColors.lightErrorColor,
        onSecondary: AppColors.lightOnSecondaryColor,
        onSurface: AppColors.lightOnSurfaceColor,
        onError: AppColors.lightOnErrorColor,
        brightness: Brightness.light,
        shadow: AppColors.lightShadowColor,
        surfaceContainerHigh: AppColors.lightSurfaceContainerHighColor,
        surfaceContainerLow: AppColors.lightSurfaceContainerLowColor,
        tertiaryFixed: AppColors.lightTertiaryFixedColor,
        tertiaryFixedDim: AppColors.lightTertiaryFixedDimColor,
        surfaceContainer: AppColors.lightSurfaceContainerColor,
      ),
      textTheme: textTheme,
      primaryColor: AppColors.lightPrimaryColor,
      brightness: Brightness.light,
      primaryIconTheme: const IconThemeData(color: AppColors.lightPrimaryColor),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightSurfaceColor,
        titleTextStyle: textTheme.headlineLarge?.copyWith(
          color: AppColors.lightPrimaryColor,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        foregroundColor: AppColors.lightPrimaryColor,
        iconTheme: const IconThemeData(color: AppColors.lightPrimaryColor),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.lightShadowColor.withAlpha(50),
      ),
      scaffoldBackgroundColor: AppColors.lightSecondaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurfaceColor,
        unselectedItemColor: AppColors.lightOnSurfaceColor,
        selectedItemColor: AppColors.lightPrimaryColor,
        selectedLabelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.lightPrimaryContainerColor,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.lightOnPrimaryColor,
          ),
          backgroundColor: AppColors.lightPrimaryFixedColor,
          foregroundColor: AppColors.lightOnPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.lightPrimaryFixedColor,
          ),
          foregroundColor: AppColors.lightPrimaryFixedColor,
          side: const BorderSide(
            color: AppColors.lightSurfaceContainerLowColor,
            width: 2,
          ),
          backgroundColor: AppColors.lightOnPrimaryVariantColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppNumbers.smallRadius),
          ),
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.lightPrimaryFixedColor),
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightPrimaryFixedColor;
          }
          return AppColors.lightPrimaryFixedColor;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightPrimaryColor;
          }
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppNumbers.miniRadius),
        ),

        checkColor: WidgetStateProperty.resolveWith<Color>(
          (state) => (state.contains(WidgetState.selected))
              ? AppColors.lightOnPrimaryColor
              : AppColors.lightOnPrimaryColor,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightPrimaryFixedColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppNumbers.miniPadding),
        filled: true,
        fillColor: AppColors.lightOnPrimaryVariantColor,
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      iconTheme: const IconThemeData(color: AppColors.lightPrimaryFixedColor),
      cardTheme: const CardThemeData(
        color: AppColors.lightSurfaceColor,
        elevation: 4.0,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppColorsExtension(
          overtime: AppColors.lightOvertime,
          unselectedTabBarColor: AppColors.lightUnselectedTabBarColor,
          splashColor: AppColors.lightSplashColor,
          selectedTabBarColor: AppColors.lightSelectedTabBarColor,
          hbaigeColor: AppColors.lighthBaigeColor,
        ),
      ],
    );
  }

  /// Dark Theme Builder
  static ThemeData darkTheme() {
    final base = ThemeData.dark();
    final textTheme = darkTextTheme(base.textTheme.apply(fontFamily: 'Cairo'));

    return base.copyWith(
      textTheme: textTheme,
      colorScheme: const ColorScheme(
        secondaryFixed: AppColors.darkSecondaryFixedColor,
        primary: AppColors.darkPrimaryColor,
        onPrimary: AppColors.darkOnPrimaryColor,
        primaryFixed: AppColors.darkPrimaryFixedColor,
        onPrimaryFixed: AppColors.darkOnPrimaryVariantColor,
        secondary: AppColors.darkSecondaryColor,
        primaryContainer: AppColors.darkPrimaryContainerColor,
        secondaryContainer: AppColors.darkSecondaryContainerColor,
        onSecondaryContainer: AppColors.darkOnSecondaryContainerColor,
        surface: AppColors.darkSurfaceColor,
        secondaryFixedDim: AppColors.darkSecondaryFixedDim,
        error: AppColors.darkErrorColor,
        onSecondary: AppColors.darkOnSecondaryColor,
        onSurface: AppColors.darkOnSurfaceColor,
        onError: AppColors.darkOnErrorColor,
        brightness: Brightness.dark,
        shadow: AppColors.darkShadowColor,
        surfaceContainerHigh: AppColors.darkSurfaceContainerHighColor,
        surfaceContainerLow: AppColors.darkSurfaceContainerLowColor,
        tertiaryFixed: AppColors.darkTertiaryFixedColor,
        tertiaryFixedDim: AppColors.darkTertiaryFixedDimColor,
        surfaceContainer: AppColors.darkSurfaceContainerColor,
      ),
      primaryColor: AppColors.darkPrimaryColor,
      brightness: Brightness.dark,
      primaryIconTheme: const IconThemeData(color: AppColors.darkPrimaryColor),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurfaceColor,
        titleTextStyle: textTheme.headlineLarge?.copyWith(
          color: AppColors.darkOnSurfaceColor,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        foregroundColor: AppColors.darkOnSurfaceColor,
        iconTheme: const IconThemeData(color: AppColors.darkOnSurfaceColor),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.darkShadowColor.withAlpha(50),
      ),
      scaffoldBackgroundColor: AppColors.darkSecondaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurfaceColor,
        unselectedItemColor: AppColors.darkOnSurfaceColor,
        selectedItemColor: AppColors.darkPrimaryColor,
        selectedLabelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.darkPrimaryContainerColor,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkOnPrimaryColor,
          ),
          backgroundColor: AppColors.darkPrimaryFixedColor,
          foregroundColor: AppColors.darkOnPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkPrimaryColor,
          ),
          foregroundColor: AppColors.darkPrimaryColor,
          side: const BorderSide(
            color: AppColors.darkSurfaceContainerLowColor,
            width: 2,
          ),
          backgroundColor: AppColors.darkOnPrimaryVariantColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppNumbers.mediumRadius),
          ),
        ),
      ),

      searchBarTheme: SearchBarThemeData(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.darkPrimaryColor),
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimaryFixedColor;
          }
          return AppColors.darkPrimaryColor;
        }),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimaryColor;
          }
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppNumbers.miniRadius),
        ),
        checkColor: WidgetStateProperty.resolveWith<Color>(
          (state) => (state.contains(WidgetState.selected))
              ? AppColors.darkOnPrimaryColor
              : AppColors.darkOnPrimaryColor,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkPrimaryColor,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppNumbers.miniPadding),
        filled: true,
        fillColor: AppColors.darkOnPrimaryVariantColor,
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),

      iconTheme: const IconThemeData(color: AppColors.darkPrimaryColor),

      cardTheme: const CardThemeData(
        color: AppColors.darkSurfaceColor,
        elevation: 4.0,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppColorsExtension(
          splashColor: AppColors.darkSplashColor,
          overtime: AppColors.darkOvertime,
          unselectedTabBarColor: AppColors.darkUnselectedTabBarColor,
          selectedTabBarColor: AppColors.darkSelectedTabBarColor,
          hbaigeColor: AppColors.darkhBaigeColor,
        ),
      ],
    );
  }

  /// Light Text Theme Modifier
  static TextTheme lightTextTheme(TextTheme baseTheme) => baseTheme.copyWith(
    displayLarge: baseTheme.displayLarge?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: baseTheme.displayMedium?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: baseTheme.displaySmall?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: baseTheme.headlineLarge?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: baseTheme.headlineMedium?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: baseTheme.headlineSmall?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: baseTheme.titleLarge?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: baseTheme.titleMedium?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: baseTheme.titleSmall?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: baseTheme.bodyLarge?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: baseTheme.bodyMedium?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: baseTheme.bodySmall?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: baseTheme.labelLarge?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: baseTheme.labelMedium?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: baseTheme.labelSmall?.copyWith(
      color: AppColors.lightOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
  );

  /// Dark Text Theme Modifier
  static TextTheme darkTextTheme(TextTheme baseTheme) => baseTheme.copyWith(
    displayLarge: baseTheme.displayLarge?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: baseTheme.displayMedium?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: baseTheme.displaySmall?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: baseTheme.headlineLarge?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: baseTheme.headlineMedium?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: baseTheme.headlineSmall?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: baseTheme.titleLarge?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: baseTheme.titleMedium?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: baseTheme.titleSmall?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: baseTheme.bodyLarge?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: baseTheme.bodyMedium?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: baseTheme.bodySmall?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: baseTheme.labelLarge?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: baseTheme.labelMedium?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: baseTheme.labelSmall?.copyWith(
      color: AppColors.darkOnSurfaceColor,
      fontWeight: FontWeight.w600,
    ),
  );
}

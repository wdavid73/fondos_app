import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/theme/theme.dart';
import 'package:flutter_starter_kit/config/theme/theme_constants.dart';

import './widget_themes/widget_themes.dart';

class LightTheme {
  static final colorScheme = ThemeConstants.colorScheme;
  static final baseIconTheme = ThemeConstants.baseIconTheme;
  static final _baseAppBarTheme = ThemeConstants.baseAppBarTheme;
  static final _baseCardTheme = ThemeConstants.baseCardTheme;
  static final _baseDividerTheme = ThemeConstants.baseDividerTheme;
  static final _baseChipTheme = ThemeConstants.baseChipTheme;
  static final _baseFABTheme = ThemeConstants.baseFABTheme;
  static final _resolveColorStatusWith = ThemeConstants.resolveColorStatusWith;
  static final _baseDrawerTheme = ThemeConstants.baseDrawerTheme;
  static final _baseListTileTheme = ThemeConstants.baseListTileTheme;
  static final _baseSnackBarTheme = ThemeConstants.baseSnackBarTheme;
  static final _baseProgressIndicatorTheme =
      ThemeConstants.baseProgressIndicatorTheme;
  static final _baseBottomSheetTheme = ThemeConstants.baseBottomSheetTheme;
  static final _baseSwitchTheme = ThemeConstants.baseSwitchTheme;
  static final _baseRadioTheme = ThemeConstants.baseRadioTheme;
  static final _baseCheckboxTheme = ThemeConstants.baseCheckboxTheme;
  static final _baseBottomNavigationBar =
      ThemeConstants.baseBottomNavigationBar;
  static final _baseNavigationRail = ThemeConstants.baseNavigationRail;
  static final _baseNavigationDrawer = ThemeConstants.baseNavigationDrawer;
  static final _baseIconTheme = ThemeConstants.baseIconTheme;
  static final _basePopupMenuThemeData = ThemeConstants.basePopupMenuThemeData;

  static ThemeData getLightTheme(BuildContext context) {
    final textScaleFactor = context.tsf.scale(ThemeConstants.fontSizeFactor);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: AppTypography.fontFamily,
      iconTheme: baseIconTheme.copyWith(
        color: ColorTheme.secondaryColor,
        size: context.dp(1.8),
      ),
      textTheme: baseTextTheme.apply(fontSizeFactor: textScaleFactor),
      appBarTheme: _baseAppBarTheme.copyWith(
        backgroundColor: ColorTheme.white,
        surfaceTintColor: ColorTheme.primaryColor,
        iconTheme: baseIconTheme.copyWith(
          color: ColorTheme.secondaryColor,
        ),
      ),
      cardTheme: _baseCardTheme.copyWith(
        color: ColorTheme.backgroundColor,
      ),
      dividerTheme: _baseDividerTheme,
      chipTheme: _baseChipTheme.copyWith(
        labelStyle: baseTextTheme.bodyMedium?.copyWith(
          color: ColorTheme.textPrimary,
        ),
      ),
      elevatedButtonTheme: getBaseElevatedButtonTheme(
        fontSizeFactor: textScaleFactor,
      ),
      textButtonTheme: getBaseTextButtonTheme(fontSizeFactor: textScaleFactor),
      outlinedButtonTheme: getBaseOutlinedButtonTheme(
        fontSizeFactor: textScaleFactor,
      ),
      filledButtonTheme: getBaseFilledButtonTheme(
        fontSizeFactor: textScaleFactor,
      ),
      floatingActionButtonTheme: _baseFABTheme,
      iconButtonTheme: getBaseIconButtonTheme(
        iconColorResolver: _resolveColorStatusWith,
        iconSize: context.dp(3),
      ),
      drawerTheme: _baseDrawerTheme,
      listTileTheme: _baseListTileTheme,
      snackBarTheme: _baseSnackBarTheme,
      progressIndicatorTheme: _baseProgressIndicatorTheme,
      bottomSheetTheme: _baseBottomSheetTheme,
      switchTheme: _baseSwitchTheme.copyWith(
        padding: EdgeInsets.zero,
        trackOutlineWidth: WidgetStatePropertyAll<double>(1.5),
      ),
      radioTheme: _baseRadioTheme,
      checkboxTheme: _baseCheckboxTheme,
      inputDecorationTheme: getBaseInputDecorationTheme(
        fontSizeFactor: textScaleFactor,
      ),
      datePickerTheme: baseDatePickerTheme,
      bottomNavigationBarTheme: _baseBottomNavigationBar,
      navigationRailTheme: _baseNavigationRail,
      navigationDrawerTheme: _baseNavigationDrawer.copyWith(
        iconTheme: WidgetStatePropertyAll(
          _baseIconTheme.copyWith(
            size: context.dp(1.8),
          ),
        ),
      ),
      popupMenuTheme: _basePopupMenuThemeData.copyWith(
        iconSize: context.dp(3),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/config/theme/theme_constants.dart';

import './widget_themes/widget_themes.dart';

/// A utility class that provides the complete dark theme configuration for the application.
///
/// This class centralizes all theme data specific to the dark mode,
/// leveraging constants from [ThemeConstants], [ColorTheme], and [AppTypography]
/// to ensure a consistent look and feel across the app.
///
/// It constructs a [ThemeData] object suitable for a dark theme,
/// including specific styles for app bars, cards, buttons, navigation elements,
/// and more, adapting text sizes based on the device's text scale factor.
class DarkTheme {
  /// The base color scheme for the dark theme, sourced from [ThemeConstants].
  static final darkColorScheme = ThemeConstants.darkColorScheme;

  /// The base icon theme data for the dark theme, sourced from [ThemeConstants].
  static final baseIconTheme = ThemeConstants.baseIconTheme;

  /// The base app bar theme data for the dark theme.
  static final _baseAppBarTheme = ThemeConstants.baseAppBarDarkTheme;

  /// The base card theme data for the dark theme.
  static final _baseCardTheme = ThemeConstants.baseCardTheme;

  /// The base divider theme data for the dark theme.
  static final _baseDividerTheme = ThemeConstants.baseDividerTheme;

  /// The base chip theme data for the dark theme.
  static final _baseChipTheme = ThemeConstants.baseChipTheme;

  /// The base Floating Action Button (FAB) theme data for the dark theme.
  static final _baseFABTheme = ThemeConstants.baseFABTheme;

  /// The base drawer theme data for the dark theme.
  static final _baseDrawerTheme = ThemeConstants.baseDrawerTheme;

  /// The base list tile theme data for the dark theme.
  static final _baseListTileTheme = ThemeConstants.baseListTileTheme;

  /// The base snack bar theme data for the dark theme.
  static final _baseSnackBarTheme = ThemeConstants.baseSnackBarTheme;

  /// The base progress indicator theme data for the dark theme.
  static final _baseProgressIndicatorTheme =
      ThemeConstants.baseProgressIndicatorTheme;

  /// The base bottom sheet theme data for the dark theme.
  static final _baseBottomSheetTheme = ThemeConstants.baseBottomSheetTheme;

  /// The base switch theme data for the dark theme.
  static final _baseSwitchTheme = ThemeConstants.baseSwitchTheme;

  /// The base radio button theme data for the dark theme.
  static final _baseRadioTheme = ThemeConstants.baseRadioTheme;

  /// The base checkbox theme data for the dark theme.
  static final _baseCheckboxTheme = ThemeConstants.baseCheckboxTheme;

  /// The base bottom navigation bar theme data for the dark theme.
  static final _baseBottomNavigationBar =
      ThemeConstants.baseBottomNavigationBar;

  /// The base navigation rail theme data for the dark theme.
  static final _baseNavigationRail = ThemeConstants.baseNavigationRail;

  /// The base navigation drawer theme data for the dark theme.
  static final _baseNavigationDrawer = ThemeConstants.baseNavigationDrawer;

  /// The base icon theme data for the dark theme.
  /// Note: This seems to be a duplicate of [baseIconTheme] above.
  static final _baseIconTheme = ThemeConstants.baseIconTheme;

  /// The base popup menu theme data for the dark theme.
  static final _basePopupMenuThemeData = ThemeConstants.basePopupMenuThemeData;

  /// Resolver for color status, typically used for interactive widget states.
  static final _resolveColorStatusWith = ThemeConstants.resolveColorStatusWith;

  /// Generic color resolver function.
  static final _resolveColorWith = ThemeConstants.resolveColorWith;

  /// Resolver for [IconThemeData].
  static final _resolveIconThemeDataWith =
      ThemeConstants.resolveIconThemeDataWith;

  /// Resolver for [TextStyle].
  static final _resolveTextStyleWith = ThemeConstants.resolveTextStyleWith;

  /// Returns the complete [ThemeData] object configured for the dark theme.
  ///
  /// This method applies specific styling for various Flutter widgets
  /// to align with the dark theme's design language. It uses values from
  /// [ThemeConstants], [ColorTheme], and [AppTypography].
  ///
  /// The [context] is used to retrieve the device's text scale factor
  /// to adjust font sizes accordingly, ensuring responsiveness.
  ///
  /// @param context The current [BuildContext] from the widget tree.
  /// @returns A [ThemeData] object configured for the dark theme.
  ///
  ///
  static ThemeData getDarkTheme(BuildContext context) {
    final fontSizeFactor = context.tsf.scale(ThemeConstants.fontSizeFactor);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      fontFamily: AppTypography.fontFamily,
      textTheme: baseTextThemeDark.apply(fontSizeFactor: fontSizeFactor),
      iconTheme: _baseIconTheme.copyWith(
        color: ColorTheme.lightPrimaryColor,
        size: context.dp(1.8),
      ),
      appBarTheme: _baseAppBarTheme,
      cardTheme: _baseCardTheme.copyWith(
        color: ColorTheme.backgroundColorDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: ColorTheme.white,
            width: 2,
          ),
        ),
      ),
      dividerTheme: _baseDividerTheme,
      chipTheme: _baseChipTheme.copyWith(
        backgroundColor: ColorTheme.secondaryColor,
        side: BorderSide(color: ColorTheme.secondaryColor, width: 1),
      ),
      elevatedButtonTheme:
          getBaseElevatedButtonTheme(fontSizeFactor: fontSizeFactor),
      textButtonTheme:
          getBaseTextButtonDarkTheme(fontSizeFactor: fontSizeFactor),
      outlinedButtonTheme:
          getBaseOutlinedButtonDarkTheme(fontSizeFactor: fontSizeFactor),
      filledButtonTheme:
          getBaseFilledButtonTheme(fontSizeFactor: fontSizeFactor),
      floatingActionButtonTheme: _baseFABTheme.copyWith(
        foregroundColor: ColorTheme.white,
      ),
      iconButtonTheme: getBaseIconButtonDarkTheme(
        iconColorResolver: _resolveColorStatusWith,
        iconSize: context.dp(3),
      ),
      drawerTheme: _baseDrawerTheme.copyWith(
        backgroundColor: ColorTheme.backgroundColorDark,
        scrimColor: ColorTheme.lightPrimaryColor.withValues(alpha: 0.5),
      ),
      listTileTheme: _baseListTileTheme.copyWith(
        textColor: ColorTheme.white,
        iconColor: ColorTheme.lightPrimaryColor,
        titleTextStyle: baseTextThemeDark.labelLarge,
        subtitleTextStyle: baseTextThemeDark.labelSmall?.copyWith(
          fontSize: 10,
        ),
      ),
      snackBarTheme: _baseSnackBarTheme.copyWith(
        contentTextStyle: baseTextThemeDark.bodyLarge,
      ),
      progressIndicatorTheme: _baseProgressIndicatorTheme,
      bottomSheetTheme: _baseBottomSheetTheme.copyWith(
        backgroundColor: ColorTheme.backgroundColorDark,
        dragHandleColor: ColorTheme.white,
      ),
      switchTheme: _baseSwitchTheme.copyWith(
        trackColor: _resolveColorWith(
          ColorTheme.secondaryColor,
          ColorTheme.textSecondary,
        ),
        trackOutlineColor: WidgetStatePropertyAll<Color>(Colors.transparent),
      ),
      radioTheme: _baseRadioTheme.copyWith(
        fillColor: WidgetStatePropertyAll<Color>(
          ColorTheme.lightPrimaryColor,
        ),
      ),
      checkboxTheme: _baseCheckboxTheme.copyWith(
        fillColor: _resolveColorWith(
          ColorTheme.secondaryColor,
          Colors.transparent,
        ),
        checkColor: _resolveColorWith(
          ColorTheme.lightPrimaryColor,
          Colors.transparent,
        ),
        side: BorderSide(color: ColorTheme.white),
      ),
      inputDecorationTheme: getBaseInputDecorationDarkTheme(
        fontSizeFactor: fontSizeFactor,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: getBaseInputDecorationDarkTheme(
          fontSizeFactor: fontSizeFactor,
        ),
      ),
      datePickerTheme: baseDatePickerDarkTheme,
      bottomNavigationBarTheme: _baseBottomNavigationBar.copyWith(
        backgroundColor: ColorTheme.navigationBackgroundColorDark,
      ),
      navigationRailTheme: _baseNavigationRail.copyWith(
        backgroundColor: ColorTheme.navigationBackgroundColorDark,
      ),
      navigationDrawerTheme: _baseNavigationDrawer.copyWith(
        backgroundColor: ColorTheme.navigationBackgroundColorDark,
        iconTheme: _resolveIconThemeDataWith(
          _baseIconTheme.copyWith(
            color: ColorTheme.primaryColor,
            size: context.dp(1.8),
          ),
          _baseIconTheme,
        ),
        labelTextStyle: _resolveTextStyleWith(
          baseTextThemeDark.labelLarge!.copyWith(
            color: ColorTheme.textPrimary,
          ),
          baseTextThemeDark.labelLarge!.copyWith(
            color: ColorTheme.lightPrimaryColor,
          ),
        ),
      ),
      popupMenuTheme: _basePopupMenuThemeData.copyWith(
        iconSize: context.dp(3),
      ),
    );
  }
}

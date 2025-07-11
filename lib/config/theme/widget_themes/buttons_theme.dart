import 'package:flutter/material.dart';

import '../theme.dart';
import 'widget_themes.dart';

/// Constants for buttons
// Definition of a common border radius for the buttons
final double _borderRadius = 12;

/// Base theme for ElevatedButton. Used as a starting point for customizing the button styles in both light and dark themes.
ElevatedButtonThemeData getBaseElevatedButtonTheme(
        {double? fontSizeFactor = 1, Color fontColor = Colors.white}) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorTheme.secondaryColor, // Button background color
        foregroundColor: ColorTheme.white, // Button text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        elevation: 5, // Elevation to give the button a shadow effect
        textStyle: fontSizeFactor != null
            ? baseTextTheme.bodyMedium
                ?.apply(fontSizeFactor: fontSizeFactor)
                .copyWith(color: fontColor)
            : baseTextTheme.bodyMedium?.copyWith(color: fontColor),
      ),
    );

/// Base theme for TextButton. Similar to ElevatedButton, but with no background color and a more minimalist style.
TextButtonThemeData getBaseTextButtonTheme({double? fontSizeFactor = 1}) =>
    TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: fontSizeFactor != null
            ? baseTextTheme.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
            : baseTextTheme.bodyMedium,
        padding: EdgeInsets.zero,
        overlayColor: Colors.transparent,
      ),
    );

/// Base theme for TextButton in dark mode.
TextButtonThemeData getBaseTextButtonDarkTheme({double? fontSizeFactor = 1}) =>
    TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: fontSizeFactor != null
            ? baseTextTheme.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
            : baseTextTheme.bodyMedium,
        foregroundColor: ColorTheme.white,
        padding: EdgeInsets.zero,
        overlayColor: Colors.transparent,
      ),
    );

/// Base theme for OutlinedButton. Similar to TextButton but with a border around it.
OutlinedButtonThemeData getBaseOutlinedButtonTheme(
        {double? fontSizeFactor = 1}) =>
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: fontSizeFactor != null
            ? baseTextTheme.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
            : baseTextTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
      ),
    );

/// Base theme for OutlinedButton in dark mode.
OutlinedButtonThemeData getBaseOutlinedButtonDarkTheme(
        {double? fontSizeFactor = 1}) =>
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: fontSizeFactor != null
            ? baseTextTheme.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
            : baseTextTheme.bodyMedium,
        foregroundColor: ColorTheme.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            _borderRadius,
          ),
        ),
      ),
    );

/// Base theme for FilledButton. Similar to ElevatedButton but with filled background and no shadow.
FilledButtonThemeData getBaseFilledButtonTheme({double? fontSizeFactor = 1}) =>
    FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: fontSizeFactor != null
            ? baseTextTheme.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
            : baseTextTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
      ),
    );

typedef ColorResolver = WidgetStateProperty<Color?> Function(
    Color enabledColor, Color disabledColor);

/// Base theme for IconButton. In this case, it doesn't specify any customization but can be extended.
IconButtonThemeData getBaseIconButtonTheme({
  required ColorResolver iconColorResolver,
  required double iconSize,
}) {
  return IconButtonThemeData(
    style: ButtonStyle(
      iconSize: WidgetStatePropertyAll<double>(iconSize),
      iconColor: iconColorResolver(
        ColorTheme.secondaryColor,
        ColorTheme.disable,
      ),
    ),
  );
}

IconButtonThemeData getBaseIconButtonDarkTheme({
  required ColorResolver iconColorResolver,
  required double iconSize,
}) {
  return IconButtonThemeData(
    style: ButtonStyle(
      iconSize: WidgetStatePropertyAll<double>(iconSize),
      iconColor: iconColorResolver(
        ColorTheme.lightPrimaryColor,
        ColorTheme.disable,
      ),
    ),
  );
}

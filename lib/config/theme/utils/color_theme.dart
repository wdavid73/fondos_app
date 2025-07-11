import 'package:flutter/material.dart';

class ColorTheme {
  // Color to text
  static Color textPrimary = HexColor.fromHex("#212121");
  static Color textSecondary = HexColor.fromHex("#757575");
  static Color iconsColor = HexColor.fromHex("#FFFFFF");

  // Color of theme
  static Color primaryColor = HexColor.fromHex("#3F51B5");
  static Color lightPrimaryColor = HexColor.fromHex("#C5CAE9");
  static Color secondaryColor = HexColor.fromHex("#303F9F");
  static Color accentColor = HexColor.fromHex("#00BCD4");

  // Backgrounds of theme
  static Color backgroundColor = HexColor.fromHex("#FFFFFF");
  static Color backgroundColorDark = HexColor.fromHex("#272727");
  static Color backgroundLight = HexColor.fromHex("#f4f4f4");
  static Color navigationBackgroundColorDark = HexColor.fromHex("#272b36");
  static Color navigationBackgroundColorLight = HexColor.fromHex("#E8EAF6");

  // Utils
  static Color error = HexColor.fromHex("#EF5350");
  static Color divider = HexColor.fromHex("#BDBDBD");
  static Color success = HexColor.fromHex("#4caf50");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color disable = HexColor.fromHex("#bcbcbc");
}

extension HexColor on Color {
  /// Converts a hex color string to a [Color] object.
  /// The hex string can optionally start with '#' or not.
  /// If the hex string does not contain an alpha value, it will default to fully opaque (FF).
  static Color fromHex(String hexColor) {
    // Trim spaces and remove the '#' symbol if present
    hexColor = hexColor.trim().replaceAll("#", "");

    // Ensure that the hex color code has 6 or 8 characters (RGB or RGBA format)
    if (hexColor.length == 6) {
      // Add the alpha value 'FF' (fully opaque) for 6 character codes
      hexColor = 'FF$hexColor';
    } else if (hexColor.length != 8) {
      // Throw an exception if the hex color is not valid (not 6 or 8 characters long)
      throw FormatException(
          "Invalid hex color format. It should be either 6 or 8 characters long.");
    }

    // Parse the hex string to an integer and return a Color
    return Color(int.parse('0x$hexColor'));
  }
}
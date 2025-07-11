import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

class AppTypography {
  // Font Family
  static const String fontFamily = 'MontserratAlternates';

  // Font Weights
  static const FontWeight lightWeight = FontWeight.w300;
  static const FontWeight regularWeight = FontWeight.w400;
  static const FontWeight mediumWeight = FontWeight.w500;
  static const FontWeight semiBoldWeight = FontWeight.w600;
  static const FontWeight boldWeight = FontWeight.w700;

  // Font Sizes
  static const double tinySize = 12;
  static const double smallSize = 14;
  static const double mediumSize = 16;
  static const double largeSize = 18;
  static const double hugeSize = 20;
  static const double extraHugeSize = 22;

  // TextStyles
  static TextStyle _textStyleDefault({
    String fontFamilyDefault = fontFamily,
    FontWeight fontWeightDefault = regularWeight,
    double fontSizeDefault = mediumSize,
    Color? color,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
    double? fontSize,
  }) =>
      TextStyle(
        fontFamily: fontFamilyDefault,
        fontSize: fontSize ?? fontSizeDefault,
        color: color ?? ColorTheme.textPrimary,
        fontWeight: fontWeightDefault,
        fontStyle: fontStyle,
        decoration: textDecoration,
      );

  static TextStyle getLightStyle({
    double? fontSize,
    Color? color,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
  }) =>
      _textStyleDefault(
        color: color ?? ColorTheme.textPrimary,
        fontWeightDefault: lightWeight,
        fontStyle: fontStyle,
        textDecoration: textDecoration,
        fontSize: fontSize,
      );

  static TextStyle getRegularStyle({
    double? fontSize,
    Color? color,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
  }) =>
      _textStyleDefault(
        color: color ?? ColorTheme.textPrimary,
        fontWeightDefault: regularWeight,
        fontStyle: fontStyle,
        textDecoration: textDecoration,
        fontSize: fontSize,
      );

  static TextStyle getMediumStyle({
    double? fontSize,
    Color? color,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
  }) =>
      _textStyleDefault(
        color: color ?? ColorTheme.textPrimary,
        fontWeightDefault: mediumWeight,
        fontStyle: fontStyle,
        textDecoration: textDecoration,
        fontSize: fontSize,
      );

  static TextStyle getSemiBoldStyle({
    double? fontSize,
    Color? color,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
  }) =>
      _textStyleDefault(
        color: color ?? ColorTheme.textPrimary,
        fontWeightDefault: semiBoldWeight,
        fontStyle: fontStyle,
        textDecoration: textDecoration,
        fontSize: fontSize,
      );

  static TextStyle getBoldStyle({
    double? fontSize,
    Color? color,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
  }) =>
      _textStyleDefault(
        color: color ?? ColorTheme.textPrimary,
        fontWeightDefault: boldWeight,
        fontStyle: fontStyle,
        textDecoration: textDecoration,
        fontSize: fontSize,
      );
}

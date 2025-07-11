import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/theme/theme.dart';

import 'text_theme.dart';

final _baseBorderSideInput = BorderSide(
  color: ColorTheme.backgroundColorDark,
  width: 1.5,
);
final _baseOutlineInputBorder = OutlineInputBorder(
  borderSide: _baseBorderSideInput,
  borderRadius: BorderRadius.circular(12),
);

/// Base InputDecorationTheme. Used as a starting point for customizing the input decoration styles in light.
InputDecorationTheme getBaseInputDecorationTheme(
        {double? fontSizeFactor = 1}) =>
    InputDecorationTheme(
      isDense: true,
      hintStyle: fontSizeFactor != null
          ? baseTextTheme.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.bodyMedium,
      labelStyle: fontSizeFactor != null
          ? baseTextTheme.labelLarge?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.labelLarge,
      floatingLabelStyle: fontSizeFactor != null
          ? baseTextTheme.labelLarge?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.labelLarge,
      helperStyle: fontSizeFactor != null
          ? baseTextTheme.bodySmall?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.bodySmall,
      errorStyle: fontSizeFactor != null
          ? baseTextTheme.bodySmall
              ?.apply(fontSizeFactor: fontSizeFactor)
              .copyWith(color: ColorTheme.error)
          : baseTextTheme.bodySmall?.copyWith(color: ColorTheme.error),
      counterStyle: fontSizeFactor != null
          ? baseTextTheme.bodySmall?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextTheme.bodySmall,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      suffixIconColor: ColorTheme.secondaryColor,
      prefixIconColor: ColorTheme.secondaryColor,
      enabledBorder: _baseOutlineInputBorder,
      disabledBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.disable,
        ),
      ),
      focusedBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.secondaryColor,
        ),
      ),
      errorBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.error,
        ),
      ),
      focusedErrorBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.error,
        ),
      ),
    );

/// Base InputDecorationDarkTheme. Used as a starting point for customizing the input decoration styles in dark themes.
InputDecorationTheme getBaseInputDecorationDarkTheme(
        {double? fontSizeFactor = 1}) =>
    getBaseInputDecorationTheme(fontSizeFactor: fontSizeFactor).copyWith(
      hintStyle: fontSizeFactor != null
          ? baseTextThemeDark.bodyMedium?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.bodyMedium,
      labelStyle: fontSizeFactor != null
          ? baseTextThemeDark.labelLarge?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.labelLarge,
      floatingLabelStyle: fontSizeFactor != null
          ? baseTextThemeDark.labelLarge?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.labelLarge,
      helperStyle: fontSizeFactor != null
          ? baseTextThemeDark.bodySmall?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.bodySmall,
      counterStyle: fontSizeFactor != null
          ? baseTextThemeDark.bodySmall?.apply(fontSizeFactor: fontSizeFactor)
          : baseTextThemeDark.bodySmall,
      suffixIconColor: ColorTheme.lightPrimaryColor,
      prefixIconColor: ColorTheme.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      enabledBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.lightPrimaryColor,
        ),
      ),
      focusedBorder: _baseOutlineInputBorder.copyWith(
        borderSide: _baseBorderSideInput.copyWith(
          color: ColorTheme.white,
        ),
      ),
      errorStyle: fontSizeFactor != null
          ? baseTextThemeDark.bodySmall
              ?.apply(fontSizeFactor: fontSizeFactor)
              .copyWith(color: ColorTheme.error)
          : baseTextThemeDark.bodySmall?.copyWith(color: ColorTheme.error),
    );

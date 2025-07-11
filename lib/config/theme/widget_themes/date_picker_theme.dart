import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/theme/theme.dart';

import 'text_theme.dart';

final baseDatePickerTheme = DatePickerThemeData(
  headerBackgroundColor: ColorTheme.primaryColor,
  headerForegroundColor: ColorTheme.white,
  dayBackgroundColor: _resolveColorWith(
    ColorTheme.primaryColor,
    Colors.transparent,
  ),
  dayForegroundColor: _resolveColorWith(
    ColorTheme.white,
    ColorTheme.textPrimary,
  ),
  yearBackgroundColor: _resolveColorWith(
    ColorTheme.primaryColor,
    Colors.transparent,
  ),
  yearForegroundColor: _resolveColorWith(
    ColorTheme.white,
    ColorTheme.textPrimary,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  headerHeadlineStyle: baseTextTheme.titleLarge,
  yearStyle: baseTextTheme.titleMedium,
  rangePickerHeaderHelpStyle: baseTextTheme.bodyLarge,
  headerHelpStyle: baseTextTheme.titleMedium,
  rangePickerHeaderHeadlineStyle: baseTextTheme.titleMedium,
  rangePickerHeaderBackgroundColor: ColorTheme.primaryColor,
  rangePickerHeaderForegroundColor: ColorTheme.white,
  rangeSelectionOverlayColor: _resolveColorWith(
    ColorTheme.primaryColor,
    ColorTheme.secondaryColor,
  ),
  rangePickerShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  rangeSelectionBackgroundColor: ColorTheme.primaryColor.withValues(
    alpha: 0.6,
  ),
);

final baseDatePickerDarkTheme = baseDatePickerTheme.copyWith(
  backgroundColor: ColorTheme.backgroundColorDark,
  headerBackgroundColor: ColorTheme.primaryColor,
  headerForegroundColor: ColorTheme.white,
  surfaceTintColor: ColorTheme.backgroundColorDark.withValues(
    alpha: 0.3,
  ),
  dayBackgroundColor: _resolveColorWith(
    ColorTheme.primaryColor,
    Colors.transparent,
  ),
  dayForegroundColor: _resolveColorWith(
    ColorTheme.white,
    ColorTheme.white,
  ),
  yearBackgroundColor: _resolveColorWith(
    ColorTheme.primaryColor,
    Colors.transparent,
  ),
  yearForegroundColor: _resolveColorWith(
    ColorTheme.white,
    ColorTheme.white,
  ),
  rangePickerBackgroundColor: ColorTheme.backgroundColorDark,
);

WidgetStateProperty<Color?> _resolveColorWith(
  Color selectedColor,
  Color unselectedColor,
) {
  return WidgetStateProperty.resolveWith<Color?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return selectedColor;
      }
      return unselectedColor;
    },
  );
}

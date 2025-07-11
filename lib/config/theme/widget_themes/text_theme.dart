import 'package:flutter/material.dart';

import '../theme.dart';

/// Base TextTheme. Used as a starting point for customizing the text styles in both light and dark themes.
TextTheme baseTextTheme = TextTheme(
  //* Display Text Styles
  displayLarge: AppTypography.getBoldStyle(fontSize: 57),
  displayMedium: AppTypography.getSemiBoldStyle(fontSize: 45),
  displaySmall: AppTypography.getSemiBoldStyle(fontSize: 36),
  //* Headline Text Styles
  headlineLarge: AppTypography.getSemiBoldStyle(fontSize: 32),
  headlineMedium: AppTypography.getMediumStyle(fontSize: 28),
  headlineSmall: AppTypography.getMediumStyle(fontSize: 24),
  //* Title Text Styles
  titleLarge: AppTypography.getSemiBoldStyle(fontSize: 22),
  titleMedium: AppTypography.getMediumStyle(fontSize: 16),
  titleSmall: AppTypography.getMediumStyle(fontSize: 14),
  //* Body Text Styles
  bodyLarge: AppTypography.getRegularStyle(fontSize: 16),
  bodyMedium: AppTypography.getRegularStyle(fontSize: 14),
  bodySmall: AppTypography.getRegularStyle(fontSize: 12),
  //* Label Text Styles
  labelLarge: AppTypography.getMediumStyle(fontSize: 14),
  labelMedium: AppTypography.getMediumStyle(fontSize: 12),
  labelSmall: AppTypography.getRegularStyle(fontSize: 11),
);

TextTheme baseTextThemeDark = TextTheme(
  //* Display Text Styles
  displayLarge: baseTextTheme.displayLarge?.copyWith(color: ColorTheme.white),
  displayMedium: baseTextTheme.displayMedium?.copyWith(color: ColorTheme.white),
  displaySmall: baseTextTheme.displaySmall?.copyWith(color: ColorTheme.white),
  //* Headline Text Styles
  headlineLarge: baseTextTheme.headlineLarge?.copyWith(color: ColorTheme.white),
  headlineMedium:
      baseTextTheme.headlineMedium?.copyWith(color: ColorTheme.white),
  headlineSmall: baseTextTheme.headlineSmall?.copyWith(color: ColorTheme.white),
  //* Title Text Styles
  titleLarge: baseTextTheme.titleLarge?.copyWith(color: ColorTheme.white),
  titleMedium: baseTextTheme.titleMedium?.copyWith(color: ColorTheme.white),
  titleSmall: baseTextTheme.titleSmall?.copyWith(color: ColorTheme.white),
  //* Body Text Styles
  bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: ColorTheme.white),
  bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: ColorTheme.white),
  bodySmall: baseTextTheme.bodySmall?.copyWith(color: ColorTheme.white),
  //* Label Text Styles
  labelLarge: baseTextTheme.labelLarge?.copyWith(color: ColorTheme.white),
  labelMedium: baseTextTheme.labelMedium?.copyWith(color: ColorTheme.white),
  labelSmall: baseTextTheme.labelSmall?.copyWith(color: ColorTheme.white),
);

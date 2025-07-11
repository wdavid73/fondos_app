import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/theme/theme.dart';

class AppSpacing {
  static const Widget xs = SizedBox(height: 4, width: 4);
  static const Widget sm = SizedBox(height: 8, width: 8);
  static const Widget md = SizedBox(height: 16, width: 16);
  static const Widget lg = SizedBox(height: 24, width: 24);
  static const Widget xl = SizedBox(height: 32, width: 32);

  static Widget vertical(double size) => SizedBox(height: size);
  static Widget horizontal(double size) => SizedBox(width: size);

  static Widget adaptiveVertical(BuildContext context, double percentage) =>
      SizedBox(height: context.height * (percentage / 100));

  static Widget adaptiveHorizontal(BuildContext context, double percentage) =>
      SizedBox(width: context.width * (percentage / 100));
}

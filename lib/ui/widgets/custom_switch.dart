import 'package:flutter/material.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/ui/shared/shared.dart';

/// A customizable switch widget with optional icon, title, and subtitle.
///
/// Displays a row with an icon, title, optional subtitle, and a switch. Useful for settings or toggles.
class CustomSwitch extends StatelessWidget {
  /// The main title to display next to the switch.
  final String title;

  /// An optional subtitle to display below the title.
  final String? subTitle;

  /// An optional icon to display before the title.
  final Icon? icon;

  /// The current value of the switch.
  final bool switchValue;

  /// Callback triggered when the switch value changes.
  final void Function(bool)? onChanged;

  /// Optional font size for the title.
  final double? titleFontSize;

  /// Creates a [CustomSwitch] widget.
  const CustomSwitch({
    super.key,
    required this.title,
    this.subTitle,
    this.icon,
    this.switchValue = false,
    this.onChanged,
    this.titleFontSize,
  });

  @override

  /// Builds the widget tree for the custom switch.
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) icon!,
            if (icon != null) AppSpacing.sm,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontSize: titleFontSize,
                  ),
                ),
                if (subTitle != null)
                  Text(
                    "$subTitle",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: ColorTheme.textSecondary,
                      fontSize:
                          titleFontSize != null ? titleFontSize! - 2 : null,
                    ),
                  ),
              ],
            ),
          ],
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: switchValue,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}

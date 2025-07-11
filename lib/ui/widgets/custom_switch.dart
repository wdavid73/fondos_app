import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Icon? icon;
  final bool switchValue;
  final void Function(bool)? onChanged;
  final double? titleFontSize;

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

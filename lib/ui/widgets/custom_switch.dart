import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final Icon? icon;
  final bool switchValue;
  final void Function(bool)? onChanged;
  const CustomSwitch({
    super.key,
    required this.title,
    this.icon,
    this.switchValue = false,
    this.onChanged,
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
            AppSpacing.sm,
            Text(
              title,
              style: context.textTheme.bodyMedium,
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

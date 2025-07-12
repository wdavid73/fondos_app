import 'package:flutter/material.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/ui/shared/styles/app_spacing.dart';

/// A reusable radio button selector for any data type [T].
///
/// Displays a vertical list of [RadioListTile] widgets with dynamic labels and values.
/// Ideal for enums, strings, or any list of objects where a single choice is required.
class CustomRadioGroupField<T> extends StatelessWidget {
  /// The list of options to display.
  final List<T> options;

  /// The currently selected option.
  final T? selectedValue;

  /// Callback triggered when a new option is selected.
  final ValueChanged<T> onChanged;

  /// A function that returns a display label for each option.
  final String Function(T) labelBuilder;

  final String? errorMessage;

  final String label;

  /// Creates a generic [CustomRadioGroupField] widget.
  ///
  /// All parameters are required except [selectedValue], which may be null.
  const CustomRadioGroupField({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.labelBuilder,
    required this.label,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelLarge,
        ),
        Column(
          children: options.map((option) {
            return RadioListTile<T>(
              title: Text(
                labelBuilder(option),
                style: context.textTheme.bodyLarge,
              ),
              value: option,
              groupValue: selectedValue,
              onChanged: (value) {
                if (value != null) onChanged(value);
              },
            );
          }).toList(),
        ),
        AppSpacing.sm,
        if (errorMessage != null)
          Text(
            "$errorMessage",
            style: context.textTheme.bodySmall?.copyWith(
              color: ColorTheme.error,
            ),
          )
      ],
    );
  }
}

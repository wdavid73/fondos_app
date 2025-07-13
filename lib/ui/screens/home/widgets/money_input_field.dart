import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fondos_app/ui/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

/// A custom input field for entering money amounts with formatting.
///
/// Formats the input as currency and notifies changes.
class MoneyInputField extends StatefulWidget {
  /// Optional controller for the input field.
  final TextEditingController? controller;

  /// Callback triggered when the value changes.
  final void Function(String)? onChanged;

  /// Error message to display below the field.
  final String? errorMessage;

  /// Creates a [MoneyInputField] widget.
  const MoneyInputField(
      {super.key, this.controller, this.onChanged, this.errorMessage});

  @override
  State<MoneyInputField> createState() => _MoneyInputFieldState();
}

/// State for [MoneyInputField].
///
/// Manages the controller, formatting, and value changes.
class _MoneyInputFieldState extends State<MoneyInputField> {
  late TextEditingController _controller;

  final formatter = NumberFormat("#,###", 'es_CO');

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_formatValue);
  }

  /// Formats the value in the controller as currency.
  void _formatValue() {
    String text = _controller.text.replaceAll('.', '').replaceAll(',', '');
    if (text.isEmpty) return;

    final number = int.tryParse(text);
    if (number == null) return;

    final newText = formatter.format(number);

    if (_controller.text != newText) {
      final selectionIndex = newText.length;
      _controller.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: selectionIndex));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_formatValue);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override

  /// Builds the widget tree for the money input field.
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      label: "Amount of investment",
      hint: "Example: \$500.000",
      prefixIcon: Icon(FluentIcons.money_24_filled),
      prefixText: "COP ",
      onChanged: widget.onChanged,
      errorMessage: widget.errorMessage,
    );
  }
}

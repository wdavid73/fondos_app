import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fondos_app/ui/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

class MoneyInputField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? errorMessage;

  const MoneyInputField(
      {super.key, this.controller, this.onChanged, this.errorMessage});

  @override
  State<MoneyInputField> createState() => _MoneyInputFieldState();
}

class _MoneyInputFieldState extends State<MoneyInputField> {
  late TextEditingController _controller;

  final formatter = NumberFormat("#,###", 'es_CO');

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_formatValue);
  }

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

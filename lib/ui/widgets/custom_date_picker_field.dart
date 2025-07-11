import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A custom date picker field widget.
///
/// This widget is used to display a date picker field with customizable properties.
class CustomDatePickerField extends StatefulWidget {
  /// The text to display when the field is empty.
  final String hintText;

  /// The label to display above the field.
  final String? label;

  /// The helper text to display below the field.
  final String? errorMessage;

  /// The helper text to display below the field.
  final String? helpText;

  /// The text to display when the user confirms the date selection.
  final String? confirmText;

  /// The text to display when the user cancels the date selection.
  final String? cancelText;

  /// An optional controller to control the text field.
  final TextEditingController? controller;

  /// The date format to use when displaying the selected date.
  final String dateFormat;

  /// The initial entry mode for the date picker.
  final DatePickerEntryMode initialEntryMode;

  /// The initial date to display in the date picker.
  final DateTime? initialDate;

  /// The first date to display in the date picker.
  final DateTime? firstDate;

  /// The last date to display in the date picker.
  final DateTime? lastDate;

  const CustomDatePickerField({
    super.key,
    required this.hintText,
    this.controller,
    this.dateFormat = "yyyy-MM-dd",
    this.initialEntryMode = DatePickerEntryMode.calendarOnly,
    this.label,
    this.errorMessage,
    this.helpText,
    this.confirmText,
    this.cancelText,
    this.firstDate,
    this.lastDate,
    this.initialDate,
  });

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  late TextEditingController _internalController;

  @override
  void initState() {
    _internalController = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _updateControllerText(DateTime? date) {
    if (date != null) {
      _internalController.text = DateFormat(widget.dateFormat).format(date);
    } else {
      _internalController.text = '';
    }
  }

  void _onTapDate() async {
    Locale myLocale = Localizations.localeOf(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate: widget.lastDate ?? DateTime(2100),
      locale: myLocale,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      fieldHintText: widget.hintText,
      fieldLabelText: widget.label,
      initialEntryMode: widget.initialEntryMode,
    );
    _updateControllerText(picked);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _internalController,
      readOnly: true,
      onTap: _onTapDate,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.label,
        helperText: widget.helpText,
        errorText: widget.errorMessage != '' ? widget.errorMessage : null,
      ),
    );
  }
}
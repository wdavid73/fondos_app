import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:intl/intl.dart';

/// A custom date picker field widget.
///
/// This widget is used to display a date picker field with customizable properties.
class CustomRangeDatePickerField extends StatefulWidget {
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

  /// The initial date range to display in the date picker.
  final DateTimeRange? initialDateRange;

  /// The initial date to display in the date picker.
  final DateTime? firstDate;

  /// The last date to display in the date picker.
  final DateTime? lastDate;

  const CustomRangeDatePickerField({
    super.key,
    required this.hintText,
    this.controller,
    this.dateFormat = "yyyy-MM-dd",
    this.label,
    this.errorMessage,
    this.helpText,
    this.confirmText,
    this.cancelText,
    this.firstDate,
    this.lastDate,
    this.initialDateRange,
    this.initialEntryMode = DatePickerEntryMode.calendarOnly,
  });

  @override
  State<CustomRangeDatePickerField> createState() =>
      _CustomRangeDatePickerFieldState();
}

class _CustomRangeDatePickerFieldState
    extends State<CustomRangeDatePickerField> {
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

  void _onTapDate() async {
    Locale myLocale = Localizations.localeOf(context);
    DateTimeRange? rangePicked = await showDateRangePicker(
      context: context,
      locale: myLocale,
      initialDateRange: widget.initialDateRange,
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate: widget.lastDate ?? DateTime(2100),
      saveText: widget.confirmText,
      initialEntryMode: widget.initialEntryMode,
      builder: (context, child) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: BoxConstraints(
              maxWidth: context.wp(90),
              maxHeight: context.hp(90),
            ),
            child: child!,
          ),
        );
      },
    );

    _internalController.text = rangePicked != null
        ? "${DateFormat(widget.dateFormat).format(rangePicked.start)} - ${DateFormat(widget.dateFormat).format(rangePicked.end)}"
        : '';
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

import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

class CustomDropdownFormField extends StatelessWidget {
  final List<dynamic> options;
  final DropdownMenuItem<dynamic> Function(dynamic value) itemBuilder;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;

  final BoxDecoration? decoration;
  final Icon? icon;
  final double iconSize;
  final Color? iconDisabledColor;
  final FocusNode? focusNode;
  final String? errorMessage;
  final String? helperText;
  final String? label;
  final Widget? prefixIcon;

  final String hint;
  final String hintDisable;

  const CustomDropdownFormField({
    super.key,
    required this.options,
    required this.itemBuilder,
    this.onChanged,
    this.validator,
    this.decoration,
    this.icon,
    this.focusNode,
    this.iconDisabledColor,
    this.iconSize = 25,
    this.errorMessage,
    this.helperText,
    this.prefixIcon,
    this.label,
    this.hint = 'select_an_option',
    this.hintDisable = 'select_an_option_disabled',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: DropdownButtonFormField<dynamic>(
        items: options.map((value) => itemBuilder(value)).toList(),
        decoration: InputDecoration(
          labelText: label,
          errorText: errorMessage != '' ? errorMessage : null,
          helperText: helperText,
          prefixIcon: prefixIcon,
          hintMaxLines: 1,
          errorMaxLines: 2,
          helperMaxLines: 2,
        ),
        menuMaxHeight: context.hp(35),
        icon: icon,
        iconSize: iconSize,
        iconDisabledColor: iconDisabledColor,
        iconEnabledColor: ColorTheme.primaryColor,
        focusNode: focusNode,
        isExpanded: true,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

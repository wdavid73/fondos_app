import 'package:formz/formz.dart';

/// Enumeration of possible errors for the [Text] input.
enum TextInputError {
  /// Indicates that the input is empty.
  empty('is_required'),

  /// Indicates that the input is too short.
  tooShort('too_short'),

  /// Indicates that the input has an invalid format.
  invalidFormat('invalid_format');

  /// The error message associated with this error.
  final String message;

  /// Creates a [TextInputError] with the given [message].
  const TextInputError(this.message);
}

/// Input model for validating text using [FormzInput].
///
/// Supports validation for minimum length and regular expression format.
class TextInput extends FormzInput<String, TextInputError> {
  /// Minimum allowed length for the text.
  final int? minLength;

  /// Optional regular expression to validate the text format.
  final RegExp? format;

  /// Creates a pure (unmodified) text instance.
  ///
  /// Used when the field is initialized without user interaction.
  const TextInput.pure({this.minLength, this.format}) : super.pure('');

  /// Creates a dirty (modified) text instance.
  ///
  /// Used when the field has been modified by the user.
  const TextInput.dirty({String value = '', this.minLength, this.format})
      : super.dirty(value);

  /// Returns the error message associated with the input.
  ///
  /// Returns `null` if the value is valid or pure.
  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  /// Validates the input value.
  ///
  /// Returns a [TextInputError] if the input does not meet any of the following conditions:
  /// - Not empty or containing only whitespace.
  /// - Meets the minimum length (if provided).
  /// - Matches the regular expression format (if provided).
  @override
  TextInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TextInputError.empty;
    if (minLength != null && value.length < minLength!) {
      return TextInputError.tooShort;
    }
    if (format != null && !format!.hasMatch(value)) {
      return TextInputError.invalidFormat;
    }
    return null;
  }
}

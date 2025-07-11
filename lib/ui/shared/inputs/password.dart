import 'package:formz/formz.dart';

/// Input model for validating passwords using [FormzInput].
///
/// Provides validation for non-empty values and minimum length requirements.
enum PasswordInputError {
  /// Error when the input is empty or contains only whitespace.
  empty('is_required'),

  /// Error when the input does not meet the minimum length.
  length('is_password_length'),

  /// Error when the input does not match the required pattern.
  pattern('is_invalid_password_pattern');

  /// Error message associated with the validation error.
  final String message;

  /// Creates a [PasswordInputError] with an associated message.
  const PasswordInputError(this.message);
}

/// Represents a password input with validation rules.
///
/// Supports validation for empty values and a minimum length of 6 characters.
class Password extends FormzInput<String, PasswordInputError> {
  /// Creates a pure (unmodified) password instance.
  ///
  /// Used when the field is initialized without user interaction.
  const Password.pure() : super.pure('');

  /// Creates a dirty (modified) password instance.
  ///
  /// Used when the field has been modified by the user.
  const Password.dirty({String value = ''}) : super.dirty(value);

  /// Returns the error message associated with the input.
  ///
  /// Returns `null` if the value is valid or pure.
  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  /// Validates the input value.
  ///
  /// Returns a [PasswordInputError] if the input does not meet any of the following conditions:
  /// - Not empty or containing only whitespace.
  /// - Minimum length of 6 characters.
  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordInputError.empty;
    if (value.length < 6) return PasswordInputError.length;
    if (!_passwordRegex.hasMatch(value)) return PasswordInputError.pattern;
    return null;
  }

  /// Regular expression pattern for password validation.
  static final _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,20}$',
  );
}
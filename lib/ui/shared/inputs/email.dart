import 'package:formz/formz.dart';

/// Input model for validating email address using [FormzInput].
///
/// Provides validation to ensure the email is not empty and follows the correct format.
enum EmailInputError {
  /// Error when the email input is empty or contains only whitespace.
  empty('is_required'),

  /// Error when the email input does not follow a valid email format.
  format('is_email');

  /// Error message associated with the validation error.
  final String message;

  /// Creates an [EmailInputError] with an associated message.
  const EmailInputError(this.message);
}

/// Represents an email input field with validation rules.
///
/// Supports validation for:
/// - Non-empty email.
/// - Correct email format.
class Email extends FormzInput<String, EmailInputError> {
  /// Regular expression to validate the email format.
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Creates a pure (unmodified) email instance.
  ///
  /// Used when the email field is initialized without user interaction.
  const Email.pure() : super.pure('');

  /// Creates a dirty (modified) email instance.
  ///
  /// Used when the email field has been modified by the user.
  const Email.dirty({String value = ''}) : super.dirty(value);

  /// Returns the error message associated with the email input.
  ///
  /// Returns `null` if the value is valid or pure.
  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  /// Validates the input value.
  ///
  /// Returns a [EmailInputError] if:
  /// - The email is empty or contains only whitespace.
  /// - The email format does not match the valid email pattern.
  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailInputError.empty;
    if (!emailRegExp.hasMatch(value)) return EmailInputError.format;
    return null;
  }
}
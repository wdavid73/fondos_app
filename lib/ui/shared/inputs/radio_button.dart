import 'package:formz/formz.dart';

/// Input model for validating radio button selection using [FormzInput].
///
/// Provides validation to ensure that exactly one option is selected.
enum RadioButtonError {
  /// Error when no item is selected.
  empty('is_required'),

  /// Error when an invalid option is selected.
  invalidOption('invalid_option');

  /// Error message associated with the validation error.
  final String message;

  /// Creates a [RadioButtonError] with an associated message.
  const RadioButtonError(this.message);
}

/// Represents a radio button selection input with validation rules.
///
/// Supports validation for:
/// - Exactly one item selected.
class RadioButton<T> extends FormzInput<T, RadioButtonError> {
  /// Creates a pure (unmodified) radio button instance.
  ///
  /// Used when the field is initialized without user interaction.
  const RadioButton.pure() : super.pure(null as T);

  /// Creates a dirty (modified) radio button instance.
  ///
  /// Used when the field has been modified by the user.
  const RadioButton.dirty({T? value}) : super.dirty(value ?? (null as T));

  /// Returns the error message associated with the input.
  ///
  /// Returns `null` if the value is valid or pure.
  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  /// Validates the input value.
  ///
  /// Returns a [RadioButtonError] if:
  /// - No option is selected (null).
  /// - The selected option is invalid (if the value is null or invalid).
  @override
  RadioButtonError? validator(T value) {
    if (value == null) return RadioButtonError.empty;
    // Optionally, you can add further validation for an invalid option.
    return null;
  }
}
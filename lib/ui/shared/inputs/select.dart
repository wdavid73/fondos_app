import 'package:formz/formz.dart';

/// Input model for validating selectable values using [FormzInput].
///
/// Provides validation to ensure a non-null value is selected.
enum SelectError {
  /// Error when no value is selected (null value).
  empty('is_required');

  /// Error message associated with the validation error.
  final String message;

  /// Creates a [SelectError] with an associated message.
  const SelectError(this.message);
}

/// Represents a selectable input with validation rules.
///
/// Supports validation to ensure a non-null value is selected.
class Select<T> extends FormzInput<T, SelectError> {
  /// Creates a pure (unmodified) select instance.
  ///
  /// Used when the field is initialized without user interaction.
  const Select.pure() : super.pure(null as T);

  /// Creates a dirty (modified) select instance.
  ///
  /// Used when the field has been modified by the user.
  const Select.dirty({T? value}) : super.dirty(value ?? (null as T));

  /// Returns the error message associated with the input.
  ///
  /// Returns `null` if the value is valid or pure.
  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  /// Validates the input value.
  ///
  /// Returns a [SelectError] if the input is null.
  @override
  SelectError? validator(T value) {
    if (value == null) return SelectError.empty;
    return null;
  }
}
import 'package:formz/formz.dart';

/// Input model for validating multiple selectable values using [FormzInput].
///
/// Provides validation to ensure at least one item is selected.
enum MultiSelectError {
  /// Error when no items are selected (empty list).
  empty('is_required');

  /// Error message associated with the validation error.
  final String message;

  /// Creates a [MultiSelectError] with an associated message.
  const MultiSelectError(this.message);
}

/// Represents a multiple selection input with validation rules.
///
/// Supports validation to ensure the list is not empty.
class MultiSelect<T> extends FormzInput<List<T>, MultiSelectError> {
  /// Creates a pure (unmodified) multi-select instance.
  ///
  /// Used when the field is initialized without user interaction.
  const MultiSelect.pure() : super.pure(const []);

  /// Creates a dirty (modified) multi-select instance.
  ///
  /// Used when the field has been modified by the user.
  const MultiSelect.dirty({List<T>? value}) : super.dirty(value ?? const []);

  /// Returns the error message associated with the input.
  ///
  /// Returns `null` if the value is valid or pure.
  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  /// Validates the input value.
  ///
  /// Returns a [MultiSelectError] if the list is empty.
  @override
  MultiSelectError? validator(List<T> value) {
    if (value.isEmpty) return MultiSelectError.empty;
    return null;
  }
}
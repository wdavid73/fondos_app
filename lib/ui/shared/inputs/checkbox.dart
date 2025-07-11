import 'package:formz/formz.dart';

/// Input model for validating checkbox selections using [FormzInput].
///
/// Provides validation to ensure at least one item is selected and
/// optionally restricts the maximum number of selected items.
enum CheckboxError {
  /// Error when no items are selected (empty list).
  empty('is_required'),

  /// Error when the number of selected items exceeds the maximum allowed.
  tooManySelected('too_many_selected');

  /// Error message associated with the validation error.
  final String message;

  /// Creates a [CheckboxError] with an associated message.
  const CheckboxError(this.message);
}

/// Represents a checkbox selection input with validation rules.
///
/// Supports validation for:
/// - At least one item selected.
/// - Optional maximum number of selected items.
class Checkbox<T> extends FormzInput<List<T>, CheckboxError> {
  /// Maximum allowed selected items.
  final int? maxSelected;

  /// Creates a pure (unmodified) checkbox instance.
  ///
  /// Used when the field is initialized without user interaction.
  const Checkbox.pure({this.maxSelected}) : super.pure(const []);

  /// Creates a dirty (modified) checkbox instance.
  ///
  /// Used when the field has been modified by the user.
  const Checkbox.dirty({List<T>? value, this.maxSelected})
      : super.dirty(value ?? const []);

  /// Returns the error message associated with the input.
  ///
  /// Returns `null` if the value is valid or pure.
  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  /// Validates the input value.
  ///
  /// Returns a [CheckboxError] if:
  /// - The list is empty.
  /// - The number of selected items exceeds the maximum allowed (if specified).
  @override
  CheckboxError? validator(List<T> value) {
    if (value.isEmpty) return CheckboxError.empty;

    if (maxSelected != null && value.length > maxSelected!) {
      return CheckboxError.tooManySelected;
    }

    return null;
  }
}
import 'package:formz/formz.dart';

/// Validation errors for [GenericOptionInput].
enum OptionValidationError {
  empty('is_required');

  final String message;

  const OptionValidationError(this.message);
}

/// Generic form input to validate that an option of type [T] is selected.
class GenericOptionInput<T> extends FormzInput<T?, OptionValidationError> {
  const GenericOptionInput.pure() : super.pure(null);
  const GenericOptionInput.dirty([super.value]) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  @override
  OptionValidationError? validator(T? value) {
    return value == null ? OptionValidationError.empty : null;
  }
}

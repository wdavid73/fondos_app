import 'package:formz/formz.dart';

/// Validation errors for [AmountInput].
enum AmountValidationError {
  empty('is_required'),
  invalid('is_invalid'),
  belowMinimum('is_below_minimum');

  final String message;

  const AmountValidationError(this.message);
}

/// Form input for monetary values using Formz.
class AmountInput extends FormzInput<String, AmountValidationError> {
  final double? minimumAllowed;

  const AmountInput.pure({this.minimumAllowed}) : super.pure('');
  const AmountInput.dirty(super.value, {this.minimumAllowed}) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  @override
  AmountValidationError? validator(String value) {
    final cleaned = value.replaceAll('.', '').replaceAll(',', '');
    if (cleaned.isEmpty) return AmountValidationError.empty;
    if (int.tryParse(cleaned) == null) return AmountValidationError.invalid;
    if (minimumAllowed != null && int.tryParse(cleaned)! < minimumAllowed!) {
      return AmountValidationError.belowMinimum;
    }
    return null;
  }
}

import 'package:formz/formz.dart';

enum DecimalError {
  empty('is_required'),
  zero('is_zero'),
  mustBePositive('must_be_positive'),
  mustBeNegative('must_be_negative');

  final String message;
  const DecimalError(this.message);
}

class Decimal extends FormzInput<double?, DecimalError> {
  final bool? mustBePositive;
  final bool? mustBeNegative;

  const Decimal.pure({this.mustBePositive, this.mustBeNegative})
      : super.pure(null);

  const Decimal.dirty({double? value, this.mustBePositive, this.mustBeNegative})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  @override
  DecimalError? validator(double? value) {
    if (value == null) return DecimalError.empty;

    if (value == 0) return DecimalError.zero;

    if (mustBePositive == true && value < 0) {
      return DecimalError.mustBePositive;
    }
    if (mustBeNegative == true && value > 0) {
      return DecimalError.mustBeNegative;
    }

    return null;
  }
}
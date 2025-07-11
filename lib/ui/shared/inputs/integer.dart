import 'package:formz/formz.dart';

enum IntegerError {
  empty('is_required'),
  zero('is_zero'),
  notInteger('not_integer'),
  mustBePositive('must_be_positive'),
  mustBeNegative('must_be_negative');

  final String message;
  const IntegerError(this.message);
}

class Integer extends FormzInput<int?, IntegerError> {
  final bool? mustBePositive;
  final bool? mustBeNegative;

  const Integer.pure({this.mustBePositive, this.mustBeNegative})
      : super.pure(null);

  const Integer.dirty({
    int? value,
    this.mustBePositive = true,
    this.mustBeNegative,
  }) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  @override
  IntegerError? validator(int? value) {
    if (value == null) return IntegerError.empty;

    if (value == 0) return IntegerError.zero;

    if (mustBePositive == true && value < 0) return IntegerError.mustBePositive;
    if (mustBeNegative == true && value > 0) return IntegerError.mustBeNegative;

    return null;
  }
}
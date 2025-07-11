import 'package:formz/formz.dart';

enum DateError {
  empty('is_required'),
  invalidRange('invalid_range'),
  inTheFuture('in_the_future'),
  inThePast('in_the_past');

  final String message;
  const DateError(this.message);
}

class Date extends FormzInput<DateTime?, DateError> {
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool? mustBeInTheFuture;
  final bool? mustBeInThePast;

  const Date.pure({
    this.minDate,
    this.maxDate,
    this.mustBeInTheFuture,
    this.mustBeInThePast,
  }) : super.pure(null);

  const Date.dirty({
    DateTime? value,
    this.minDate,
    this.maxDate,
    this.mustBeInTheFuture,
    this.mustBeInThePast,
  }) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  @override
  DateError? validator(DateTime? value) {
    if (value == null) return DateError.empty;

    if (_isOutRange(value)) return DateError.invalidRange;

    if (mustBeInTheFuture == true && value.isBefore(DateTime.now())) {
      return DateError.inThePast;
    }
    if (mustBeInThePast == true && value.isAfter(DateTime.now())) {
      return DateError.inTheFuture;
    }

    return null;
  }

  bool _isOutRange(DateTime value) {
    return (minDate != null && value.isBefore(minDate!)) ||
        (maxDate != null && value.isAfter(maxDate!));
  }
}
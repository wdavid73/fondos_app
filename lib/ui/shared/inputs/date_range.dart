import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

enum DateRangeError {
  empty('is_required'),
  invalidOrder('invalid_order'),
  invalidRange('invalid_range');

  final String message;
  const DateRangeError(this.message);
}

class DateRange extends FormzInput<DateTimeRange?, DateRangeError> {
  final DateTime? minDate;
  final DateTime? maxDate;

  const DateRange.pure({this.minDate, this.maxDate}) : super.pure(null);

  const DateRange.dirty({DateTimeRange? value, this.minDate, this.maxDate})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    return displayError?.message;
  }

  @override
  DateRangeError? validator(DateTimeRange? value) {
    if (value == null) return DateRangeError.empty;

    if (value.start.isAfter(value.end)) return DateRangeError.invalidOrder;

    if (minDate != null && value.start.isBefore(minDate!)) {
      return DateRangeError.invalidRange;
    }

    if (maxDate != null && value.end.isAfter(maxDate!)) {
      return DateRangeError.invalidRange;
    }

    return null;
  }
}
import 'package:intl/intl.dart';

String get currency =>
    NumberFormat.compactSimpleCurrency(locale: 'en').currencySymbol;

String formatNumber(String s) => NumberFormat.decimalPattern('es').format(
      int.parse(s, radix: 10),
    );

String? formatNumberMillion(String number) {
  int? parseNumber = int.tryParse(number, radix: 10);

  if (parseNumber == null) {
    return "";
  }

  if (parseNumber < 0) {
    "$currency$parseNumber";
  }

  String formatNum = (parseNumber).toStringAsFixed(0);
  return "COP $currency${formatNumber(formatNum)}";
}

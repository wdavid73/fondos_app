import 'package:flutter_starter_kit/data/models/fund_model.dart';

class TransactionModel {
  final String type;
  final FundModel fund;
  final String amount;
  final DateTime date;

  TransactionModel({
    required this.type,
    required this.fund,
    required this.amount,
    required this.date,
  });
}

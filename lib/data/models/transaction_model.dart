import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';

/// A model representing a transaction related to a fund.
///
/// Contains information about the transaction type, fund, amount, date, and notification method.
class TransactionModel {
  /// The type of transaction (e.g., 'buy', 'sell').
  final String type;

  /// The fund involved in the transaction.
  final FundModel fund;

  /// The amount involved in the transaction.
  final String amount;

  /// The date of the transaction.
  final DateTime date;

  /// The notification method for the transaction (optional).
  final NotificationWay? notificationWay;

  /// Creates a [TransactionModel] instance.
  TransactionModel({
    required this.type,
    required this.fund,
    required this.amount,
    required this.date,
    this.notificationWay,
  });
}

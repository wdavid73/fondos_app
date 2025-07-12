import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';

class TransactionModel {
  final String type;
  final FundModel fund;
  final String amount;
  final DateTime date;
  final NotificationWay? notificationWay;

  TransactionModel({
    required this.type,
    required this.fund,
    required this.amount,
    required this.date,
    this.notificationWay,
  });
}

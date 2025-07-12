import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/ui/shared/notification_way.dart';

class MyFundModel extends FundModel {
  final String investment;
  final NotificationWay notificationWay;

  MyFundModel({
    required super.id,
    required super.name,
    required super.amountMin,
    required super.category,
    required this.investment,
    required this.notificationWay,
  });
}

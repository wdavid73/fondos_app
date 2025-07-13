import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';

/// A model representing a user's investment in a fund.
///
/// Extends [FundModel] and adds investment amount and notification method.
class MyFundModel extends FundModel {
  /// The amount invested by the user.
  final String investment;

  /// The notification method for the investment.
  final NotificationWay notificationWay;

  /// Creates a [MyFundModel] instance.
  MyFundModel({
    required super.id,
    required super.name,
    required super.amountMin,
    required super.category,
    required this.investment,
    required this.notificationWay,
  });
}

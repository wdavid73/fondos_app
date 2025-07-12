part of 'fund_bloc.dart';

abstract class FundEvent {}

class LoadFundEvent extends FundEvent {}

class SubscribeFundEvent extends FundEvent {
  final FundModel fund;
  final String investment;
  final NotificationWay notificationWay;
  SubscribeFundEvent({
    required this.fund,
    required this.investment,
    required this.notificationWay,
  });
}

class CancelSubscribeFundEvent extends FundEvent {
  final MyFundModel fund;
  CancelSubscribeFundEvent({required this.fund});
}

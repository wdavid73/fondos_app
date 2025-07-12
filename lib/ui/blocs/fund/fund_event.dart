part of 'fund_bloc.dart';

abstract class FundEvent {}

class LoadFundEvent extends FundEvent {}

class SubscribeFundEvent extends FundEvent {
  final FundModel fund;
  SubscribeFundEvent({required this.fund});
}

class CancelSubscribeFundEvent extends FundEvent {
  final FundModel fund;
  CancelSubscribeFundEvent({required this.fund});
}

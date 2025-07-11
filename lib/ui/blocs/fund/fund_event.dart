part of 'fund_bloc.dart';

abstract class FundEvent {}

class LoadFundEvent extends FundEvent {}

class SubscribeFundEvent extends FundEvent {}

class CancelSubscribeFundEvent extends FundEvent {}

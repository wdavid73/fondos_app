part of 'fund_bloc.dart';

enum SubscribeFundStatus { none, success, cancel, error }

class FundState extends Equatable {
  final bool isLoading;
  final List<FundModel> funds;
  final List<FundModel> myFunds;
  final List<TransactionModel> transactions;
  final String errorMessage;
  final String errorSubscribe;
  final SubscribeFundStatus status;

  const FundState({
    this.isLoading = false,
    this.funds = const [],
    this.myFunds = const [],
    this.transactions = const [],
    this.errorMessage = '',
    this.errorSubscribe = '',
    this.status = SubscribeFundStatus.none,
  });

  @override
  List<Object> get props => [
        isLoading,
        funds,
        myFunds,
        errorMessage,
        status,
        errorSubscribe,
      ];

  FundState copyWith({
    bool? isLoading,
    List<FundModel>? funds,
    List<FundModel>? myFunds,
    List<TransactionModel>? transactions,
    String? errorMessage,
    String? errorSubscribe,
    SubscribeFundStatus? status,
  }) =>
      FundState(
        isLoading: isLoading ?? this.isLoading,
        funds: funds ?? this.funds,
        myFunds: myFunds ?? this.myFunds,
        transactions: transactions ?? this.transactions,
        errorMessage: errorMessage ?? this.errorMessage,
        errorSubscribe: errorSubscribe ?? this.errorSubscribe,
        status: status ?? this.status,
      );
}

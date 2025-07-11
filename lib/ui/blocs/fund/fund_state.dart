part of 'fund_bloc.dart';

class FundState extends Equatable {
  final bool isLoading;
  final List<FundModel> funds;
  final List<TransactionModel> transactions;
  final String errorMessage;

  const FundState({
    this.isLoading = false,
    this.funds = const [],
    this.transactions = const [],
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [
        isLoading,
        funds,
        errorMessage,
      ];

  FundState copyWith({
    bool? isLoading,
    List<FundModel>? funds,
    List<TransactionModel>? transactions,
    String? errorMessage,
  }) =>
      FundState(
        isLoading: isLoading ?? this.isLoading,
        funds: funds ?? this.funds,
        transactions: transactions ?? this.transactions,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

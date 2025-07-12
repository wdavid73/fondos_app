import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/data/models/transaction_model.dart';
import 'package:flutter_starter_kit/domain/usecases/fund_usecase.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';

part 'fund_event.dart';
part 'fund_state.dart';

class FundBloc extends Bloc<FundEvent, FundState> {
  final FundUsecase useCase;
  final UserCubit userCubit;

  FundBloc(this.useCase, this.userCubit) : super(FundState()) {
    on<LoadFundEvent>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true, status: SubscribeFundStatus.none));

        final response = await useCase.loadFunds();

        emit(state.copyWith(
          isLoading: false,
          funds: response,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ));
      }
    });

    on<SubscribeFundEvent>((event, emit) {
      try {
        emit(state.copyWith(status: SubscribeFundStatus.none));
        double userBalance = userCubit.state.balance;
        double fundAmount = (double.tryParse(event.fund.amountMin) ?? 0);
        if (userBalance < fundAmount) {
          emit(state.copyWith(
            status: SubscribeFundStatus.error,
            errorSubscribe:
                "the user's balance is less than the minimum amount",
          ));
          return;
        }
        double newBalance = userBalance - fundAmount;
        TransactionModel transactionModel = TransactionModel(
          type: "subscription",
          fund: event.fund,
          amount: event.fund.amountMin,
          date: DateTime.now(),
        );

        userCubit.changeBalance(newBalance);

        emit(state.copyWith(
          myFunds: [...state.myFunds, event.fund],
          transactions: [...state.transactions, transactionModel],
          status: SubscribeFundStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: SubscribeFundStatus.error,
          errorSubscribe: "Error Subscribing to fund",
        ));
      }
    });

    on<CancelSubscribeFundEvent>((event, emit) {
      try {
        emit(state.copyWith(status: SubscribeFundStatus.none));
        double currentUserBalance = userCubit.state.balance;
        double fundAmount = (double.tryParse(event.fund.amountMin) ?? 0);
        double newBalance = currentUserBalance + fundAmount;

        if (_checkElementInListById(state.myFunds, event.fund)) {
          TransactionModel transactionModel = TransactionModel(
            type: "cancellation",
            fund: event.fund,
            amount: event.fund.amountMin,
            date: DateTime.now(),
          );

          userCubit.changeBalance(newBalance);

          emit(state.copyWith(
            myFunds: state.myFunds.where((e) => e.id != event.fund.id).toList(),
            transactions: [...state.transactions, transactionModel],
            status: SubscribeFundStatus.cancel,
          ));
          return;
        } else {
          emit(state.copyWith(
            status: SubscribeFundStatus.error,
            errorSubscribe: "Error cancelling subscription",
          ));
          return;
        }
      } catch (e) {
        emit(state.copyWith(
          status: SubscribeFundStatus.error,
          errorSubscribe: "Error Subscribing to fund",
        ));
      }
    });
  }

  void loadFunds() {
    add(LoadFundEvent());
  }

  void subscribeToFund(FundModel fund) {
    add(SubscribeFundEvent(fund: fund));
  }

  void cancelSubscriptionToFund(FundModel fund) {
    add(CancelSubscribeFundEvent(fund: fund));
  }

  bool _checkElementInListById(List<dynamic> list, dynamic item) {
    bool exist = list.any((element) => element.id == item.id);
    return exist;
  }
}

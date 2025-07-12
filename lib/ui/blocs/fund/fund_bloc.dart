import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/data/models/my_fund_model.dart';
import 'package:fondos_app/data/models/transaction_model.dart';
import 'package:fondos_app/domain/usecases/fund_usecase.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';

part 'fund_event.dart';
part 'fund_state.dart';

class FundBloc extends Bloc<FundEvent, FundState> {
  final FundUsecase _useCase;
  final UserCubit _userCubit;

  FundBloc(this._useCase, this._userCubit) : super(FundState()) {
    on<LoadFundEvent>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true, status: SubscribeFundStatus.none));

        final response = await _useCase.loadFunds();

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
        double userBalance = _userCubit.state.balance;
        double fundAmount = (double.tryParse(event.investment) ?? 0);
        if (userBalance < fundAmount) {
          emit(state.copyWith(
            status: SubscribeFundStatus.error,
            errorSubscribe: "validationUserBalance",
          ));
          return;
        }
        double newBalance = userBalance - fundAmount;
        TransactionModel transactionModel = TransactionModel(
          type: "subscription",
          fund: event.fund,
          amount: event.investment,
          date: DateTime.now(),
          notificationWay: event.notificationWay,
        );

        MyFundModel myFund = MyFundModel(
          id: (state.myFunds.length + 1).toString(),
          name: event.fund.name,
          amountMin: event.fund.amountMin,
          category: event.fund.category,
          investment: event.investment,
          notificationWay: event.notificationWay,
        );

        _userCubit.changeBalance(newBalance);

        emit(state.copyWith(
          myFunds: [...state.myFunds, myFund],
          transactions: [...state.transactions, transactionModel],
          status: SubscribeFundStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: SubscribeFundStatus.error,
          errorSubscribe: "errorSubscribing",
        ));
      }
    });

    on<CancelSubscribeFundEvent>((event, emit) {
      try {
        emit(state.copyWith(status: SubscribeFundStatus.none));
        double currentUserBalance = _userCubit.state.balance;
        double fundAmount = (double.tryParse(event.fund.investment) ?? 0);
        double newBalance = currentUserBalance + fundAmount;

        if (_checkElementInListById(state.myFunds, event.fund)) {
          TransactionModel transactionModel = TransactionModel(
            type: "cancellation",
            fund: event.fund,
            amount: event.fund.investment,
            date: DateTime.now(),
            notificationWay: event.fund.notificationWay,
          );

          _userCubit.changeBalance(newBalance);

          emit(state.copyWith(
            myFunds: state.myFunds.where((e) => e.id != event.fund.id).toList(),
            transactions: [...state.transactions, transactionModel],
            status: SubscribeFundStatus.cancel,
          ));
          return;
        } else {
          emit(state.copyWith(
            status: SubscribeFundStatus.error,
            errorSubscribe: "errorCancellingSubscribing",
          ));
          return;
        }
      } catch (e) {
        emit(state.copyWith(
          status: SubscribeFundStatus.error,
          errorSubscribe: "errorSubscribing",
        ));
      }
    });
  }

  void loadFunds() {
    add(LoadFundEvent());
  }

  void subscribeToFund(
    FundModel fund,
    String investment,
    NotificationWay notificationWay,
  ) {
    add(SubscribeFundEvent(
      fund: fund,
      investment: investment,
      notificationWay: notificationWay,
    ));
  }

  void cancelSubscriptionToFund(MyFundModel fund) {
    add(CancelSubscribeFundEvent(fund: fund));
  }

  bool _checkElementInListById(List<dynamic> list, dynamic item) {
    bool exist = list.any((element) => element.id == item.id);
    return exist;
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/data/models/transaction_model.dart';
import 'package:flutter_starter_kit/domain/usecases/fund_usecase.dart';

part 'fund_event.dart';
part 'fund_state.dart';

class FundBloc extends Bloc<FundEvent, FundState> {
  final FundUsecase useCase;

  FundBloc(this.useCase) : super(FundState()) {
    on<LoadFundEvent>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true));

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
    on<SubscribeFundEvent>((event, emit) {});
    on<CancelSubscribeFundEvent>((event, emit) {});
  }

  void loadFunds() {
    add(LoadFundEvent());
  }

  void subscribeToFund() {
    add(SubscribeFundEvent());
  }

  void cancelSubscriptionToFund() {
    add(CancelSubscribeFundEvent());
  }
}

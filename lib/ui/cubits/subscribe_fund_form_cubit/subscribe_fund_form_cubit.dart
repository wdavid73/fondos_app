import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/ui/blocs/fund/fund_bloc.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';
import 'package:fondos_app/ui/shared/inputs/inputs.dart';
import 'package:fondos_app/utils/utils.dart';
import 'package:formz/formz.dart';

part 'subscribe_fund_form_state.dart';

class SubscribeFundFormCubit extends Cubit<SubscribeFundFormState> {
  final FundBloc _fundBloc;

  SubscribeFundFormCubit(this._fundBloc) : super(SubscribeFundFormState());

  void onSubmit(FundModel fund) async {
    _touchEveryField(minimumAllowed: fund.amountMin);

    if (!state.isValid) return;

    String investment =
        state.amount.value.replaceAll('.', '').replaceAll(',', '');

    emit(state.copyWith(isPosting: true));

    _fundBloc.subscribeToFund(
      fund,
      investment,
      state.notification.value!,
    );

    await waitForState(
      stream: _fundBloc.stream,
      condition: (state) =>
          state.status == SubscribeFundStatus.success ||
          state.status == SubscribeFundStatus.error,
    );

    emit(state.copyWith(isPosting: false));
  }

  void amountChanged(String value, {String minimumAllowed = '0'}) {
    double minAllow = double.parse(minimumAllowed);
    final input = AmountInput.dirty(value, minimumAllowed: minAllow);
    emit(state.copyWith(
      amount: input,
      isValid: Formz.validate([input, state.notification]),
    ));
  }

  void methodChanged(NotificationWay notification) {
    final input = GenericOptionInput<NotificationWay>.dirty(notification);
    emit(state.copyWith(
      notification: input,
      isValid: Formz.validate([state.amount, input]),
    ));
  }

  void _touchEveryField({String minimumAllowed = '0'}) {
    double minAllow = double.parse(minimumAllowed);
    final amount =
        AmountInput.dirty(state.amount.value, minimumAllowed: minAllow);
    final notification =
        GenericOptionInput<NotificationWay>.dirty(state.notification.value);

    emit(state.copyWith(
      amount: amount,
      notification: notification,
      isValid: Formz.validate([amount, notification]),
    ));
  }
}

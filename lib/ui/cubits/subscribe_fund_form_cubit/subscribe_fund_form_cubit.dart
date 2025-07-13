import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/ui/blocs/fund/fund_bloc.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';
import 'package:fondos_app/ui/shared/inputs/inputs.dart';
import 'package:fondos_app/utils/utils.dart';
import 'package:formz/formz.dart';

part 'subscribe_fund_form_state.dart';

/// Cubit that manages the state and logic for subscribing to an investment fund.
///
/// Handles form validation, submission, and updates related to the subscription process.
class SubscribeFundFormCubit extends Cubit<SubscribeFundFormState> {
  /// The [FundBloc] used to interact with fund-related actions.
  final FundBloc _fundBloc;

  /// Creates a [SubscribeFundFormCubit] instance.
  SubscribeFundFormCubit(this._fundBloc) : super(SubscribeFundFormState());

  /// Submits the subscription form for the given [fund].
  ///
  /// Validates all fields, emits a loading state, and triggers the subscription process.
  /// Waits for the result and updates the state accordingly.
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

  /// Updates the amount field and validates the form.
  ///
  /// [value] is the new amount entered by the user.
  /// [minimumAllowed] is the minimum allowed value for the investment.
  void amountChanged(String value, {String minimumAllowed = '0'}) {
    double minAllow = double.parse(minimumAllowed);
    final input = AmountInput.dirty(value, minimumAllowed: minAllow);
    emit(state.copyWith(
      amount: input,
      isValid: Formz.validate([input, state.notification]),
    ));
  }

  /// Updates the notification method field and validates the form.
  ///
  /// [notification] is the selected notification method.
  void methodChanged(NotificationWay notification) {
    final input = GenericOptionInput<NotificationWay>.dirty(notification);
    emit(state.copyWith(
      notification: input,
      isValid: Formz.validate([state.amount, input]),
    ));
  }

  /// Marks all fields as touched to trigger validation.
  ///
  /// [minimumAllowed] is the minimum allowed value for the investment.
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

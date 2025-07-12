part of 'subscribe_fund_form_cubit.dart';

class SubscribeFundFormState extends Equatable {
  final AmountInput amount;
  final GenericOptionInput<NotificationWay> notification;
  final bool isValid;
  final bool isPosting;

  const SubscribeFundFormState({
    this.amount = const AmountInput.pure(),
    this.notification = const GenericOptionInput.pure(),
    this.isValid = false,
    this.isPosting = false,
  });

  @override
  List<Object> get props => [amount, notification, isValid, isPosting];

  SubscribeFundFormState copyWith({
    AmountInput? amount,
    GenericOptionInput<NotificationWay>? notification,
    bool? isValid,
    bool? isPosting,
  }) {
    return SubscribeFundFormState(
      amount: amount ?? this.amount,
      notification: notification ?? this.notification,
      isValid: isValid ?? this.isValid,
      isPosting: isPosting ?? this.isPosting,
    );
  }
}

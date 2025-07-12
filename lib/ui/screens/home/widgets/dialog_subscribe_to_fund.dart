import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/screens/home/widgets/money_input_field.dart';
import 'package:flutter_starter_kit/ui/shared/notification_way.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';
import 'package:flutter_starter_kit/ui/shared/styles/formats.dart';
import 'package:flutter_starter_kit/ui/widgets/custom_button.dart';
import 'package:flutter_starter_kit/ui/widgets/custom_radio_group_field.dart';
import 'package:go_router/go_router.dart';

double userBalance = getIt.get<UserCubit>().state.balance;

class DialogSubscribeToFund extends StatelessWidget {
  final FundModel fund;
  const DialogSubscribeToFund({
    super.key,
    required this.fund,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SubscribeFundFormCubit>();
    final state = context.watch<SubscribeFundFormCubit>().state;

    double investment = (double.tryParse(
            cubit.state.amount.value.replaceAll(',', '').replaceAll('.', '')) ??
        0);

    return BlocListener<FundBloc, FundState>(
      bloc: getIt.get<FundBloc>(),
      listener: (context, state) {
        if (state.status == SubscribeFundStatus.success) {
          context.pop();
        }
      },
      child: Dialog(
        child: SizedBox(
          width: kIsWeb ? context.wp(40) : context.wp(70),
          height: kIsWeb ? context.hp(50) : context.hp(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(
                  "${context.l10n.invest_in} ${fund.name}",
                  style: context.textTheme.titleLarge,
                ),
                Text(
                  "${context.l10n.minimum_amount}: ${formatNumberMillion(fund.amountMin)}",
                  style: context.textTheme.bodyLarge,
                ),
                Text(
                  "${context.l10n.category}: ${fund.category}",
                  style: context.textTheme.bodyLarge,
                ),
                //

                MoneyInputField(
                  onChanged: (val) => cubit.amountChanged(
                    val,
                    minimumAllowed: fund.amountMin,
                  ),
                  errorMessage:
                      context.l10n.getByKey(state.amount.errorMessage),
                ),

                CustomRadioGroupField(
                  label: context.l10n.notificationMethod,
                  options: NotificationWay.values,
                  selectedValue: state.notification.value,
                  onChanged: cubit.methodChanged,
                  labelBuilder: (value) => value.label,
                  errorMessage:
                      context.l10n.getByKey(state.notification.errorMessage),
                ),

                BlocSelector<UserCubit, UserState, double>(
                  bloc: getIt.get<UserCubit>(),
                  selector: (state) => state.balance,
                  builder: (context, balance) {
                    return Text(
                      "${context.l10n.your_balance}: ${formatNumberMillion(balance.toString())}",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                Text(
                  "${context.l10n.next_balance}: ${formatNumberMillion((userBalance - investment).toString())}",
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                AppSpacing.lg,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    CustomButton(
                      onPressed: () => context.pop(),
                      buttonType: CustomButtonType.filledTonal,
                      label: context.l10n.cancelBtn,
                    ),
                    CustomButton(
                      isLoading: context.select<SubscribeFundFormCubit, bool>(
                        (cubit) => cubit.state.isPosting,
                      ),
                      onPressed: state.isPosting
                          ? null
                          : () {
                              cubit.onSubmit(fund);
                            },
                      label: context.l10n.confirm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

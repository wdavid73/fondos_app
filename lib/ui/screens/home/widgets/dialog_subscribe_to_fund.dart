import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';
import 'package:flutter_starter_kit/ui/shared/styles/formats.dart';
import 'package:flutter_starter_kit/ui/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class DialogSubscribeToFund extends StatelessWidget {
  final FundModel fund;
  final void Function() onConfirm;
  const DialogSubscribeToFund({
    super.key,
    required this.fund,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: kIsWeb ? context.wp(40) : context.wp(70),
        height: kIsWeb ? context.hp(40) : context.hp(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: BlocSelector<UserCubit, UserState, double>(
            bloc: getIt.get<UserCubit>(),
            selector: (state) => state.balance,
            builder: (context, balance) {
              return Column(
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
                  Text(
                    "${context.l10n.your_balance}: ${formatNumberMillion(balance.toString())}",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${context.l10n.next_balance}: ${formatNumberMillion((balance - double.parse(fund.amountMin)).toString())}",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
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
                        onPressed: onConfirm,
                        label: context.l10n.confirm,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

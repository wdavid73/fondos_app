import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/app/dependency_injection.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/data/models/my_fund_model.dart';
import 'package:fondos_app/ui/blocs/blocs.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';
import 'package:fondos_app/ui/shared/shared.dart';
import 'package:fondos_app/ui/shared/styles/formats.dart';
import 'package:fondos_app/ui/widgets/widgets.dart';

class MyInvestmentExpandedLayout extends StatelessWidget {
  const MyInvestmentExpandedLayout({super.key});

  void _onCancelSubscription(MyFundModel fund) {
    final bloc = getIt.get<FundBloc>();
    bloc.cancelSubscriptionToFund(fund);
  }

  void _listener(BuildContext context, FundState state) {
    if (state.status == SubscribeFundStatus.error) {
      CustomSnackBar.showSnackBar(
        context,
        message: context.l10n.getByKey(state.errorSubscribe),
        backgroundColor: ColorTheme.error,
        icon: FluentIcons.warning_24_filled,
      );
    }

    if (state.status == SubscribeFundStatus.cancel) {
      CustomSnackBar.showSnackBar(
        context,
        message: context.l10n.subscriptionCancelSuccess,
        backgroundColor: ColorTheme.accentColor,
        icon: FluentIcons.checkmark_24_filled,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FundBloc, FundState>(
      bloc: getIt.get<FundBloc>(),
      listener: _listener,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              context.l10n.myFunds,
              style: context.textTheme.headlineMedium,
            ),
            AppSpacing.md,
            Text(
              context.l10n.activeFunds,
              style: context.textTheme.titleMedium,
            ),
            AppSpacing.md,
            BlocSelector<FundBloc, FundState, List<MyFundModel>>(
              bloc: getIt.get<FundBloc>(),
              selector: (state) => state.myFunds,
              builder: (context, myFunds) {
                return _Table(
                  funds: myFunds,
                  onCancel: (fund) => _onCancelSubscription(fund),
                );
              },
            ),
            AppSpacing.md,
            Text(
              context.l10n.balance,
              style: context.textTheme.headlineMedium,
            ),
            AppSpacing.md,
            SizedBox(
              width: context.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        context.l10n.totalBalance,
                        style: context.textTheme.titleLarge,
                      ),
                      BlocSelector<UserCubit, UserState, double>(
                        bloc: getIt.get<UserCubit>(),
                        selector: (state) => state.balance,
                        builder: (context, balance) {
                          return Text(
                            "${formatNumberMillion(balance.toString())}",
                            style: context.textTheme.headlineMedium,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppSpacing.md,
          ],
        ),
      ),
    );
  }
}

class _Table extends StatelessWidget {
  final List<MyFundModel> funds;
  final void Function(MyFundModel fund) onCancel;
  const _Table({this.funds = const [], required this.onCancel});

  @override
  Widget build(BuildContext context) {
    final double fontSize = context.dp(1);
    return Container(
      width: context.width,
      constraints: BoxConstraints(maxHeight: context.hp(60)),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              context.l10n.fund,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.category,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.notification,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.investment,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.status,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.action,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
        ],
        rows: funds.isNotEmpty
            ? funds
                .map((fund) => DataRow(
                      cells: [
                        DataCell(Text(fund.name)),
                        DataCell(Text(fund.category)),
                        DataCell(Text(fund.notificationWay.label)),
                        DataCell(
                          Text("${formatNumberMillion(fund.investment)}"),
                        ),
                        DataCell(Chip(label: Text(context.l10n.active))),
                        DataCell(
                          CustomButton(
                            onPressed: () => onCancel(fund),
                            buttonType: CustomButtonType.text,
                            label: context.l10n.cancel,
                          ),
                        ),
                      ],
                    ))
                .toList()
            : [
                DataRow(
                  cells: [
                    DataCell(Text(context.l10n.noDataAvailable)),
                    DataCell.empty,
                    DataCell.empty,
                    DataCell.empty,
                    DataCell.empty,
                    DataCell.empty,
                  ],
                )
              ],
      ),
    );
  }
}

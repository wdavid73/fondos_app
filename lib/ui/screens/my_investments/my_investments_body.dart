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

/// Body widget for the My Investments screen.
///
/// Displays the user's active funds, allows cancellation, and shows balance information.
class MyInvestmentBody extends StatelessWidget {
  /// Creates a [MyInvestmentBody] widget.
  const MyInvestmentBody({super.key});

  /// Handles the cancellation of a fund subscription.
  void _onCancelSubscription(MyFundModel fund) {
    final bloc = getIt.get<FundBloc>();
    bloc.cancelSubscriptionToFund(fund);
  }

  /// Listener for fund state changes to show feedback.
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

  /// Builds the widget tree for the my investments body.
  Widget build(BuildContext context) {
    return BlocListener<FundBloc, FundState>(
      bloc: getIt.get<FundBloc>(),
      listener: _listener,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                context.l10n.myFunds,
                style: context.textTheme.headlineMedium,
              ),
            ),
            AppSpacing.md,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                context.l10n.activeFunds,
                style: context.textTheme.titleMedium,
              ),
            ),
            AppSpacing.md,
            BlocSelector<FundBloc, FundState, List<MyFundModel>>(
              bloc: getIt.get<FundBloc>(),
              selector: (state) => state.myFunds,
              builder: (context, myFunds) {
                return _ListInvestments(
                  funds: myFunds,
                  onCancel: (fund) => _onCancelSubscription(fund),
                );
              },
            ),
            AppSpacing.md,
            Container(
              width: context.width,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        context.l10n.totalBalance,
                        style: context.textTheme.titleMedium,
                      ),
                      BlocSelector<UserCubit, UserState, double>(
                        bloc: getIt.get<UserCubit>(),
                        selector: (state) => state.balance,
                        builder: (context, balance) {
                          return Text(
                            "${formatNumberMillion(balance.toString())}",
                            style: context.textTheme.bodyLarge,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Internal widget for displaying a list of user's funds.
class _ListInvestments extends StatelessWidget {
  /// The list of user's funds.
  final List<MyFundModel> funds;

  /// Callback triggered when the user cancels a subscription.
  final void Function(MyFundModel fund) onCancel;

  /// Creates a [_ListInvestments] widget.
  const _ListInvestments({this.funds = const [], required this.onCancel});

  @override

  /// Builds the widget tree for the funds list.
  Widget build(BuildContext context) {
    if (funds.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(context.l10n.noDataAvailable),
        ),
      );
    }
    return Expanded(
      child: ListView.separated(
        itemCount: funds.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          MyFundModel fund = funds[index];
          return ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 6,
              children: [
                Text("${context.l10n.fund}:"),
                Text(
                  fund.name,
                  style: context.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 6,
              children: [
                Text("${context.l10n.category}: ${fund.category}"),
                Text(
                    "${context.l10n.notification}: ${fund.notificationWay.label}"),
                Text(
                    "${context.l10n.investment}: ${formatNumberMillion(fund.investment)}"),
              ],
            ),
            trailing: CustomButton(
              icon: Icon(FluentIcons.dismiss_20_regular),
              onPressed: () => onCancel(fund),
              buttonType: CustomButtonType.text,
              label: context.l10n.cancel,
            ),
          );
        },
      ),
    );
  }
}

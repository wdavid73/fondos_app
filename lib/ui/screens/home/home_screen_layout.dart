import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/app/dependency_injection.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/data/models/my_fund_model.dart';
import 'package:fondos_app/ui/blocs/fund/fund_bloc.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:fondos_app/ui/screens/home/widgets/dialog_subscribe_to_fund.dart';
import 'package:fondos_app/ui/screens/home/widgets/fund_item.dart';
import 'package:fondos_app/ui/shared/styles/app_spacing.dart';
import 'package:fondos_app/ui/widgets/svg_picture_custom.dart';

/// Layout widget for the home screen displaying available investment funds.
///
/// Shows a list of funds, handles subscription dialog, and manages duplicate fund logic.
class HomeScreenLayout extends StatelessWidget {
  /// Creates a [HomeScreenLayout] widget.
  const HomeScreenLayout({super.key});

  /// Shows the dialog to subscribe to a fund.
  void _showDialog(BuildContext context, FundModel fund) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (__) => getIt.get<SubscribeFundFormCubit>())
          ],
          child: DialogSubscribeToFund(
            fund: fund,
          ),
        );
      },
    );
  }

  /// Checks if there are duplicate fund IDs between two lists.
  bool hasDuplicateId(List<FundModel> listA, List<MyFundModel> listB) {
    final idsA = listA.map((a) => a.id).toSet();
    return listB.any((b) => idsA.contains(b.id));
  }

  @override

  /// Builds the widget tree for the home screen layout.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.exploreFunds,
            style: context.textTheme.headlineMedium,
          ),
          AppSpacing.md,
          Text(
            context.l10n.descriptionExploreFunds,
            style: context.textTheme.bodyLarge,
          ),
          AppSpacing.md,
          Expanded(
            child: BlocBuilder<FundBloc, FundState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return CircularProgressIndicator.adaptive();
                }

                if (state.errorMessage.isNotEmpty) {
                  return Text(state.errorMessage);
                }

                if (state.funds.isEmpty) {
                  return SizedBox(
                    width: context.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPictureCustom(
                          iconPath: "assets/icon/empty.svg",
                          iconSize: context.dp(10),
                        ),
                        Text(
                          context.l10n.itsEmpty,
                        )
                      ],
                    ),
                  );
                }

                final myFundsId = state.myFunds.map((f) => f.id).toSet();

                return ListView.separated(
                  itemCount: state.funds.length,
                  itemBuilder: (context, index) {
                    final FundModel fund = state.funds[index];
                    bool isEnabled = !myFundsId.contains(fund.id);

                    return FundItem(
                      fund: fund,
                      enable: isEnabled,
                      onSubscribe: (FundModel fund) {
                        _showDialog(context, fund);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

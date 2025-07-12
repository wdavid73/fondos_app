import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/ui/blocs/fund/fund_bloc.dart';
import 'package:flutter_starter_kit/ui/screens/home/widgets/dialog_subscribe_to_fund.dart';
import 'package:flutter_starter_kit/ui/shared/styles/app_spacing.dart';
import 'package:flutter_starter_kit/ui/widgets/svg_picture_custom.dart';
import 'package:go_router/go_router.dart';

import '../widgets/fund_item.dart';

class HomeScreenExpandedLayout extends StatelessWidget {
  const HomeScreenExpandedLayout({super.key});

  void _showDialog(BuildContext context, FundModel fund) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (ctx) {
        return DialogSubscribeToFund(
          fund: fund,
          onConfirm: () {
            context.pop();
            final bloc = getIt.get<FundBloc>();
            bloc.subscribeToFund(fund);
          },
        );
      },
    );
  }

  @override
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

                return ListView.separated(
                  itemCount: state.funds.length,
                  itemBuilder: (context, index) {
                    final FundModel fund = state.funds[index];

                    return FundItem(
                      fund: fund,
                      enable: !state.myFunds.contains(fund),
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

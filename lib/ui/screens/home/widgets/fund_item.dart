import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/ui/shared/styles/formats.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';

class FundItem extends StatelessWidget {
  final FundModel fund;
  const FundItem({super.key, required this.fund});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        fund.name,
        style: context.textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Minimum: ${formatNumberMillion(fund.amountMin)}",
            style: context.textTheme.bodyMedium?.copyWith(
              color: ColorTheme.textSecondary,
            ),
          ),
          Text(
            "Category: ${fund.category}",
            style: context.textTheme.bodyMedium?.copyWith(
              color: ColorTheme.textSecondary,
            ),
          ),
        ],
      ),
      leading: Icon(FluentIcons.savings_24_regular),
      trailing: CustomButton(
        onPressed: () {},
        label: context.l10n.subscribe,
        buttonType: CustomButtonType.filledTonal,
      ),
    );
  }
}

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/ui/shared/styles/formats.dart';
import 'package:fondos_app/ui/widgets/widgets.dart';

class FundItem extends StatelessWidget {
  final FundModel fund;
  final void Function(FundModel fund) onSubscribe;
  final bool enable;
  const FundItem({
    super.key,
    required this.fund,
    required this.onSubscribe,
    this.enable = true,
  });

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
            "${context.l10n.minimum}: ${formatNumberMillion(fund.amountMin)}",
            style: context.textTheme.bodyMedium?.copyWith(
              color: ColorTheme.textSecondary,
            ),
          ),
          Text(
            "${context.l10n.category}: ${fund.category}",
            style: context.textTheme.bodyMedium?.copyWith(
              color: ColorTheme.textSecondary,
            ),
          ),
        ],
      ),
      leading: Icon(FluentIcons.savings_24_regular),
      trailing: CustomButton(
        onPressed: enable ? () => onSubscribe(fund) : null,
        label: context.l10n.subscribe,
        buttonType: CustomButtonType.filledTonal,
      ),
    );
  }
}

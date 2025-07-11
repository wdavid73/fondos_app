import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';

class FundItem extends StatelessWidget {
  const FundItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        "Tech Growth Fund",
        style: context.textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Minimum: \$500",
            style: context.textTheme.bodyMedium?.copyWith(
              color: ColorTheme.textSecondary,
            ),
          ),
          Text(
            "Category: Technology Stocks",
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

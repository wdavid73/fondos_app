import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget? appBar(BuildContext context) {
  return AppBar(
    actionsPadding: const EdgeInsets.all(10),
    leading: Icon(
      Icons.inventory,
      size: context.dp(1.3),
    ),
    title: Text(
      context.l10n.appName,
      style: context.textTheme.titleLarge,
    ),
    actions: [
      BlocSelector<ThemeModeCubit, ThemeModeState, bool>(
        bloc: getIt.get<ThemeModeCubit>(),
        selector: (state) => state.isDarkMode,
        builder: (context, isDarkMode) {
          return CustomSwitch(
            icon: Icon(
                isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                size: context.dp(1)),
            title: context.l10n.darkTheme,
            switchValue: isDarkMode,
            onChanged: (_) {
              getIt.get<ThemeModeCubit>().toggleTheme();
            },
          );
        },
      ),
      CustomButton(
        onPressed: () {},
        buttonType: CustomButtonType.text,
        child: Text(
          "Home",
          style: context.textTheme.titleMedium,
        ),
      ),
      AppSpacing.md,
      CustomButton(
        onPressed: () => context.pushNamed('my_investment'),
        buttonType: CustomButtonType.text,
        child: Text(
          "My Investments",
          style: context.textTheme.titleMedium,
        ),
      ),
      AppSpacing.md,
      CustomButton(
        onPressed: () => context.pushNamed('transactions'),
        buttonType: CustomButtonType.text,
        child: Text(
          "Transactions",
          style: context.textTheme.titleMedium,
        ),
      ),
      AppSpacing.md,
      CustomButton(
        onPressed: () {},
        buttonType: CustomButtonType.text,
        child: Text(
          "Settings",
          style: context.textTheme.titleMedium,
        ),
      ),
      AppSpacing.md,
      CustomButton(
        onPressed: () {},
        buttonType: CustomButtonType.text,
        child: Text(
          "Profile",
          style: context.textTheme.titleMedium,
        ),
      ),
      AppSpacing.sm,
      CircleAvatar(
        child: Icon(
          Icons.person_2,
          size: context.dp(1.4),
        ),
      ),
    ],
  );
}

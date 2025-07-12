import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/app/dependency_injection.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:fondos_app/ui/shared/shared.dart';
import 'package:fondos_app/ui/shared/styles/formats.dart';
import 'package:fondos_app/ui/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WebAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = getIt.get<UserCubit>();
    return AppBar(
      actionsPadding: const EdgeInsets.all(10),
      leading: Icon(
        Icons.attach_money_outlined,
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
          onPressed: () => context.pushNamed('home'),
          buttonType: CustomButtonType.text,
          child: Text(
            context.l10n.home,
            style: context.textTheme.titleMedium,
          ),
        ),
        AppSpacing.md,
        CustomButton(
          onPressed: () => context.pushNamed('my_investment'),
          buttonType: CustomButtonType.text,
          child: Text(
            context.l10n.myInvestments,
            style: context.textTheme.titleMedium,
          ),
        ),
        AppSpacing.md,
        CustomButton(
          onPressed: () => context.pushNamed('transactions'),
          buttonType: CustomButtonType.text,
          child: Text(
            context.l10n.transactions,
            style: context.textTheme.titleMedium,
          ),
        ),
        AppSpacing.md,
        PopupMenuButton(
          itemBuilder: (ctx) => [
            PopupMenuItem(
              enabled: false,
              labelTextStyle: WidgetStatePropertyAll(
                context.textTheme.bodyLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage('assets/images/person.jpg'),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    userCubit.state.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  BlocSelector<UserCubit, UserState, double>(
                    bloc: userCubit,
                    selector: (state) => state.balance,
                    builder: (context, balance) {
                      return Text(
                        "${context.l10n.currentBalance} ${formatNumberMillion(balance.toString())}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
          child: Text(
            context.l10n.profile,
            style: context.textTheme.titleMedium,
          ),
        ),
        AppSpacing.md,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

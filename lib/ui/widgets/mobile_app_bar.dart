import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/app/dependency_injection.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/ui/cubits/cubits.dart';
import 'package:fondos_app/ui/shared/shared.dart';
import 'package:fondos_app/ui/shared/styles/formats.dart';
import 'package:fondos_app/ui/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: const EdgeInsets.all(10),
      title: Text(
        context.l10n.appName,
        style: context.textTheme.titleLarge,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MobileDrawerAppBar extends StatelessWidget {
  const MobileDrawerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _DrawerHeader(
              userName: "Joe Doe",
              balance: "500000",
            ),
            Expanded(child: _DrawerBody()),
            AppSpacing.md,
            _LastDrawerItem(),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final String userName;
  final String balance;
  const _DrawerHeader({required this.userName, required this.balance});

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        context.textTheme.titleMedium?.copyWith(color: ColorTheme.white);
    final balanceStyle =
        context.textTheme.labelSmall?.copyWith(color: ColorTheme.white);
    final userCubit = getIt.get<UserCubit>();

    return DrawerHeader(
      decoration: BoxDecoration(color: ColorTheme.primaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 24,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/person.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          AppSpacing.md,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(userCubit.state.name, style: titleStyle),
              BlocSelector<UserCubit, UserState, double>(
                bloc: userCubit,
                selector: (state) => state.balance,
                builder: (context, balance) {
                  return Text(
                    "${context.l10n.currentBalance} ${formatNumberMillion(balance.toString())}",
                    style: balanceStyle,
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert_rounded, color: Colors.white),
        ],
      ),
    );
  }
}

class _DrawerBody extends StatelessWidget {
  const _DrawerBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _DrawerItem(
          icon: FluentIcons.home_20_filled,
          text: context.l10n.home,
          onTap: () {
            context.pushNamed('home');
            Navigator.pop(context);
          },
        ),
        _DrawerItem(
          icon: Icons.account_balance,
          text: context.l10n.myInvestments,
          onTap: () {
            context.pushNamed('my_investment');
            Navigator.pop(context);
          },
        ),
        _DrawerItem(
          icon: Icons.currency_exchange,
          text: context.l10n.transactions,
          onTap: () {
            context.pushNamed('transactions');
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  const _DrawerItem({
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.textTheme.labelLarge;
    return ListTile(
      leading: Icon(icon),
      title: Text(text, style: labelStyle),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap,
    );
  }
}

class _LastDrawerItem extends StatelessWidget {
  const _LastDrawerItem();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: BlocSelector<ThemeModeCubit, ThemeModeState, bool>(
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';
import 'package:go_router/go_router.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _DrawerHeader(userName: "Joe doe", userEmail: "joe@doe.com"),
            Expanded(child: _DrawerBody()),
            AppSpacing.md,
            _LastDrawerIcon(
              icon: Icons.logout,
              text: 'Log out',
              tileColor: ColorTheme.primaryColor,
              onTap: () => context.read<AuthBloc>().logout(),
            ),
          ],
        ),
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
          icon: Icons.widgets,
          text: "widgets",
          onTap: () {
            context.push(RouteConstants.widgetsScreen);
            Navigator.pop(context);
          },
        ),
        _DrawerItem(
          icon: Icons.api,
          text: "example api service implementation",
          onTap: () {
            context.push(RouteConstants.exampleService);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final String userName;
  final String userEmail;
  const _DrawerHeader({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        context.textTheme.titleMedium?.copyWith(color: ColorTheme.white);
    final emailStyle =
        context.textTheme.labelSmall?.copyWith(color: ColorTheme.white);

    return DrawerHeader(
      decoration: BoxDecoration(color: ColorTheme.primaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CircleAvatar(child: Icon(Icons.person)),
          AppSpacing.md,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(userName, style: titleStyle),
              Text(userEmail, style: emailStyle),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert_rounded, color: Colors.white),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color? tileColor;
  const _DrawerItem({
    required this.icon,
    required this.text,
    this.onTap,
    this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.textTheme.labelLarge;
    return ListTile(
      tileColor: tileColor,
      leading: Icon(icon),
      title: Text(text, style: labelStyle),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap,
    );
  }
}

class _LastDrawerIcon extends _DrawerItem {
  const _LastDrawerIcon({
    required super.icon,
    required super.text,
    super.onTap,
    super.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.textTheme.labelLarge?.copyWith(
      color: ColorTheme.white,
    );
    return ListTile(
      leading: Icon(icon, color: ColorTheme.white),
      tileColor: tileColor,
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: ColorTheme.white),
      title: Text(text, style: labelStyle),
      onTap: onTap,
    );
  }
}

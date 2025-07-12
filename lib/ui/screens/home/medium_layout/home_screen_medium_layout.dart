import 'package:flutter/material.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/ui/shared/shared.dart';

class HomeScreenMediumLayout extends StatelessWidget {
  const HomeScreenMediumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: FlutterLogo(
            size: context.dp(20),
          ),
        ),
        AppSpacing.md,
        Text(
          "${context.l10n.home} - Medium Layout",
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}

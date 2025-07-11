import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: Container(
          width: context.width,
          height: context.height,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ListView(
            children: [
              Text(
                context.l10n.general,
                style: context.textTheme.titleSmall,
              ),
              _ItemSettings(
                title: context.l10n.account,
                icon: Icons.person_rounded,
              ),
              _ItemSettings(
                title: context.l10n.deleteAccount,
                icon: Icons.delete_forever_rounded,
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.feedback,
                style: context.textTheme.titleSmall,
              ),
              _ItemSettings(
                title: context.l10n.reportBug,
                icon: Icons.bug_report,
              ),
              _ItemSettings(
                title: context.l10n.sendFeedback,
                icon: Icons.send_rounded,
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.theme,
                style: context.textTheme.titleSmall,
              ),
              BlocSelector<ThemeModeCubit, ThemeModeState, bool>(
                bloc: getIt.get<ThemeModeCubit>(),
                selector: (state) => state.isDarkMode,
                builder: (context, isDarkMode) {
                  return CustomSwitch(
                    icon: Icon(Icons.dark_mode_outlined, size: context.dp(2.6)),
                    title: context.l10n.darkTheme,
                    switchValue: isDarkMode,
                    onChanged: (_) {
                      getIt.get<ThemeModeCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemSettings extends StatelessWidget {
  final IconData icon;
  final String title;
  const _ItemSettings({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          contentPadding: EdgeInsets.zero,
        ),
        Divider(height: 0, endIndent: 0, indent: 0),
      ],
    );
  }
}

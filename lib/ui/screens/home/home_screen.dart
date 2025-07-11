import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';

import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';
import 'package:flutter_starter_kit/ui/screens/home/expanded_layout/home_screen_expanded_layout.dart';
import 'package:flutter_starter_kit/ui/screens/home/medium_layout/home_screen_medium_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {}

  @override
  Widget build(BuildContext context) {
    return WrapperBlocs(
      child: AdaptiveScaffold(
        expandedLayout: HomeScreenExpandedLayout(),
        mediumLayout: HomeScreenMediumLayout(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FlutterLogo(
                size: context.dp(30),
              ),
            ),
            AppSpacing.md,
            Text(
              key: Key("home_title"),
              context.l10n.appName,
              style: context.textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class WrapperBlocs extends StatelessWidget {
  final Widget child;
  const WrapperBlocs({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final fundBloc = getIt.get<FundBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: fundBloc),
      ],
      child: child,
    );
  }
}

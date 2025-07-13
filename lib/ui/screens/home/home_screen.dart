import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/app/dependency_injection.dart';
import 'package:fondos_app/ui/blocs/blocs.dart';
import 'package:fondos_app/ui/screens/home/home_screen_layout.dart';
import 'package:fondos_app/ui/widgets/widgets.dart';

import 'package:fondos_app/config/config.dart';

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

  void _init() {
    final bloc = getIt.get<FundBloc>();
    bloc.loadFunds();
  }

  void _listener(BuildContext context, FundState state) {
    if (state.status == SubscribeFundStatus.error) {
      CustomSnackBar.showSnackBar(
        context,
        message: context.l10n.getByKey(state.errorSubscribe),
        backgroundColor: ColorTheme.error,
        icon: FluentIcons.warning_24_filled,
      );
    }
    if (state.status == SubscribeFundStatus.success) {
      CustomSnackBar.showSnackBar(
        context,
        message: context.l10n.subscriptionSuccess,
        backgroundColor: ColorTheme.success,
        icon: FluentIcons.checkmark_24_filled,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WrapperBlocs(
      child: BlocListener<FundBloc, FundState>(
        bloc: getIt.get<FundBloc>(),
        listener: _listener,
        child: AdaptiveScaffold(
          child: HomeScreenLayout(),
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

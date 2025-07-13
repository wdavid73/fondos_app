import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/app/dependency_injection.dart';
import 'package:fondos_app/ui/blocs/blocs.dart';
import 'package:fondos_app/ui/screens/home/home_screen_layout.dart';
import 'package:fondos_app/ui/widgets/widgets.dart';

import 'package:fondos_app/config/config.dart';

/// Main screen widget for the home page.
///
/// Initializes the fund bloc, listens for subscription events, and displays the home layout.
class HomeScreen extends StatefulWidget {
  /// Creates a [HomeScreen] widget.
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

  /// Initializes the fund bloc by loading funds.
  void _init() {
    final bloc = getIt.get<FundBloc>();
    bloc.loadFunds();
  }

  /// Listener for fund state changes to show feedback.
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

  /// Builds the widget tree for the home screen.
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

/// Wrapper widget to provide necessary blocs to the home screen.
class WrapperBlocs extends StatelessWidget {
  /// The child widget to wrap with bloc providers.
  final Widget child;

  /// Creates a [WrapperBlocs] widget.
  const WrapperBlocs({super.key, required this.child});

  @override

  /// Builds the widget tree for the wrapper blocs.
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

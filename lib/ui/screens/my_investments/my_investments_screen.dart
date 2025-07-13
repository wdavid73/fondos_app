import 'package:flutter/material.dart';
import 'package:fondos_app/ui/screens/my_investments/expanded_layout/my_investment_expanded_layout.dart';
import 'package:fondos_app/ui/screens/my_investments/my_investments_body.dart';
import 'package:fondos_app/ui/widgets/adaptive_scaffold.dart';

/// Main screen widget for the My Investments page.
///
/// Displays the expanded and compact layouts for different screen sizes.
class MyInvestmentsScreen extends StatelessWidget {
  /// Creates a [MyInvestmentsScreen] widget.
  const MyInvestmentsScreen({super.key});

  @override

  /// Builds the widget tree for the my investments screen.
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      expandedLayout: const MyInvestmentExpandedLayout(),
      mediumLayout: const MyInvestmentExpandedLayout(),
      child: const MyInvestmentBody(),
    );
  }
}

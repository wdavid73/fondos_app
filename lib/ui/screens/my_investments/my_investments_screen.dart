import 'package:flutter/material.dart';
import 'package:fondos_app/ui/screens/my_investments/expanded_layout/my_investment_expanded_layout.dart';
import 'package:fondos_app/ui/screens/my_investments/my_investments_body.dart';
import 'package:fondos_app/ui/widgets/adaptive_scaffold.dart';

class MyInvestmentsScreen extends StatelessWidget {
  const MyInvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      expandedLayout: const MyInvestmentExpandedLayout(),
      mediumLayout: const MyInvestmentExpandedLayout(),
      child: const MyInvestmentBody(),
    );
  }
}

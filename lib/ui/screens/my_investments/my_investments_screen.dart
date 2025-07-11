import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/ui/screens/my_investments/expanded_layout/my_investment_expanded_layout.dart';
import 'package:flutter_starter_kit/ui/widgets/adaptive_scaffold.dart';

class MyInvestmentsScreen extends StatelessWidget {
  const MyInvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      expandedLayout: const MyInvestmentExpandedLayout(),
      mediumLayout: const Placeholder(),
      child: const Placeholder(),
    );
  }
}

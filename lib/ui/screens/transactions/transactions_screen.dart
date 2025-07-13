import 'package:flutter/material.dart';
import 'package:fondos_app/ui/screens/transactions/compact_layout/transaction_compact_layout.dart';
import 'package:fondos_app/ui/screens/transactions/expanded_layout/transaction_expanded_layout.dart';
import 'package:fondos_app/ui/widgets/adaptive_scaffold.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      expandedLayout: TransactionExpandedLayout(),
      mediumLayout: TransactionExpandedLayout(),
      child: TransactionCompactLayout(),
    );
  }
}

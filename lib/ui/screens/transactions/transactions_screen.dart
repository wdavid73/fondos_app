import 'package:flutter/material.dart';
import 'package:fondos_app/ui/screens/transactions/compact_layout/transaction_compact_layout.dart';
import 'package:fondos_app/ui/screens/transactions/expanded_layout/transaction_expanded_layout.dart';
import 'package:fondos_app/ui/widgets/adaptive_scaffold.dart';

/// Main screen widget for the Transactions page.
///
/// Displays the expanded and compact layouts for different screen sizes.
class TransactionsScreen extends StatelessWidget {
  /// Creates a [TransactionsScreen] widget.
  const TransactionsScreen({super.key});

  @override

  /// Builds the widget tree for the transactions screen.
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      expandedLayout: TransactionExpandedLayout(),
      mediumLayout: TransactionExpandedLayout(),
      child: TransactionCompactLayout(),
    );
  }
}

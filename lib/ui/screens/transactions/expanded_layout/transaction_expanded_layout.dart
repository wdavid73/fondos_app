import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/app/dependency_injection.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/data/models/transaction_model.dart';
import 'package:fondos_app/ui/blocs/blocs.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';
import 'package:fondos_app/ui/shared/styles/formats.dart';

/// An expanded layout widget for displaying transactions (desktop/web view).
///
/// Shows a table of transactions with details such as type, fund, notification, amount, and date.
class TransactionExpandedLayout extends StatelessWidget {
  /// Creates a [TransactionExpandedLayout] widget.
  const TransactionExpandedLayout({super.key});

  @override

  /// Builds the widget tree for the expanded transactions layout.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            context.l10n.transactions,
            style: context.textTheme.headlineMedium,
          ),
          BlocSelector<FundBloc, FundState, List<TransactionModel>>(
            bloc: getIt.get<FundBloc>(),
            selector: (state) => state.transactions,
            builder: (context, transactions) {
              return _Table(transactions: transactions);
            },
          ),
        ],
      ),
    );
  }
}

/// Internal table widget for displaying a list of transactions.
class _Table extends StatelessWidget {
  /// The list of transactions to display.
  final List<TransactionModel> transactions;

  /// Creates a [_Table] widget.
  const _Table({this.transactions = const []});

  @override

  /// Builds the widget tree for the transactions table.
  Widget build(BuildContext context) {
    final double fontSize = context.dp(1);
    return Container(
      width: context.width,
      constraints: BoxConstraints(maxHeight: context.hp(60)),
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              context.l10n.type,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.fund,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.notification,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.amount,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
          DataColumn(
            label: Text(
              context.l10n.date,
              style: context.textTheme.titleSmall?.copyWith(fontSize: fontSize),
            ),
          ),
        ],
        rows: transactions.isNotEmpty
            ? transactions
                .map((e) => DataRow(cells: [
                      DataCell(Text("${context.l10n.getByKey(e.type)}")),
                      DataCell(Text(e.fund.name)),
                      DataCell(Text(e.notificationWay?.label ?? 'No Data')),
                      DataCell(Text("${formatNumberMillion(e.amount)}")),
                      DataCell(Text(e.date.toString())),
                    ]))
                .toList()
            : [
                DataRow(
                  cells: [
                    DataCell(Text(context.l10n.noDataAvailable)),
                    DataCell.empty,
                    DataCell.empty,
                    DataCell.empty,
                    DataCell.empty,
                  ],
                )
              ],
      ),
    );
  }
}

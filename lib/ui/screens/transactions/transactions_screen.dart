import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/data/models/transaction_model.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/shared/notification_way.dart';
import 'package:flutter_starter_kit/ui/shared/styles/formats.dart';
import 'package:flutter_starter_kit/ui/widgets/adaptive_scaffold.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
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

class _Table extends StatelessWidget {
  final List<TransactionModel> transactions;
  const _Table({this.transactions = const []});

  @override
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

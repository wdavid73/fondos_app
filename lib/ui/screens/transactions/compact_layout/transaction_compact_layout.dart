import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fondos_app/app/dependency_injection.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/data/models/transaction_model.dart';
import 'package:fondos_app/ui/blocs/blocs.dart';
import 'package:fondos_app/ui/shared/notification_way.dart';
import 'package:fondos_app/ui/shared/styles/formats.dart';

class TransactionCompactLayout extends StatelessWidget {
  const TransactionCompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
              return _ListInvestments(transactions: transactions);
            },
          ),
        ],
      ),
    );
  }
}

class _ListInvestments extends StatelessWidget {
  final List<TransactionModel> transactions;

  const _ListInvestments({this.transactions = const []});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(context.l10n.noDataAvailable),
        ),
      );
    }
    return Expanded(
      child: ListView.separated(
        itemCount: transactions.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          TransactionModel transaction = transactions[index];
          return ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 6,
              children: [
                Text("${context.l10n.fund}:"),
                Text(
                  transaction.fund.name,
                  style: context.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 6,
              children: [
                Text(
                    "${context.l10n.type}: ${context.l10n.getByKey(transaction.type)}"),
                Text("${context.l10n.fund}: ${transaction.fund.name}"),
                Text(
                    "${context.l10n.notification}: ${transaction.notificationWay?.label ?? 'No Data'}"),
                Text(
                    "${context.l10n.amount}: ${formatNumberMillion(transaction.amount)}"),
                Text("${context.l10n.date}: ${transaction.date.toString()}"),
              ],
            ),
          );
        },
      ),
    );
  }
}

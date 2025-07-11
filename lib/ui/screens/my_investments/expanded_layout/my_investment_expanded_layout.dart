import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/shared/shared.dart';

class MyInvestmentExpandedLayout extends StatelessWidget {
  const MyInvestmentExpandedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            context.l10n.myFunds,
            style: context.textTheme.headlineMedium,
          ),
          AppSpacing.md,
          Text(
            context.l10n.activeFunds,
            style: context.textTheme.titleMedium,
          ),
          AppSpacing.md,
          _Table(),
          AppSpacing.md,
          Text(
            context.l10n.balance,
            style: context.textTheme.headlineMedium,
          ),
          AppSpacing.md,
          SizedBox(
            width: context.width,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      context.l10n.totalBalance,
                      style: context.textTheme.titleLarge,
                    ),
                    Text(
                      "\$10.000",
                      style: context.textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppSpacing.md,
        ],
      ),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      constraints: BoxConstraints(maxHeight: context.hp(60)),
      child: DataTable(
        columns: [
          DataColumn(label: Text("name")),
          DataColumn(label: Text("age")),
          DataColumn(label: Text("role")),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text("Sarah")),
              DataCell(Text("19")),
              DataCell(Text("Student")),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text("Sarah")),
              DataCell(Text("19")),
              DataCell(Text("Student")),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text("Sarah")),
              DataCell(Text("19")),
              DataCell(Text("Student")),
            ],
          ),
        ],
      ),
    );
  }
}

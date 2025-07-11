import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
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
          _Table(),
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

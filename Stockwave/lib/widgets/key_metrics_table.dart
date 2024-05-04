import 'package:flutter/material.dart';
import 'package:stockwave/models/company.dart';

class CompanyMetricsTable extends StatefulWidget {
  final Company firstCompany;
  final Company secondCompany;

  const CompanyMetricsTable({
    super.key,
    required this.firstCompany,
    required this.secondCompany
  });

  @override
  State<CompanyMetricsTable> createState() => _CompanyMetricsTableState();
}

class _CompanyMetricsTableState extends State<CompanyMetricsTable> {
  @override
  Widget build(BuildContext context) {

    return DataTable(
      dividerThickness: 0.1,
      headingTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
      columns: <DataColumn>[
        const DataColumn(
          label: Expanded(child: Text('Metric')),
        ),
        DataColumn(
          label: Expanded(child: Text(widget.firstCompany['symbol'])),
        ),
        DataColumn(
          label: Expanded(child: Text(widget.secondCompany['symbol'])),
        ),
      ],
      rows: widget.firstCompany.metrics.keys.map((metric) {
        return DataRow(
          cells: [
            DataCell(Text(metric)),
            DataCell(Text(widget.firstCompany.metrics[metric]!)),
            DataCell(Text(widget.secondCompany.metrics[metric]!)),
          ],
        );
      }).toList(),
    );
  }
}
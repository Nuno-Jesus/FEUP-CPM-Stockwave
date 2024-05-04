import 'package:flutter/material.dart';
import 'package:stockwave/models/company_metrics.dart';

class KeyMetricsTable extends StatefulWidget {
  final CompanyMetrics firstCompanyMetrics;
  final CompanyMetrics secondCompanyMetrics;

  const KeyMetricsTable({
    super.key,
    required this.firstCompanyMetrics,
    required this.secondCompanyMetrics
  });

  @override
  State<KeyMetricsTable> createState() => _KeyMetricsTableState();
}

class _KeyMetricsTableState extends State<KeyMetricsTable> {
  @override
  Widget build(BuildContext context) {

    return DataTable(
      dividerThickness: 0.1,
      headingTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(child: Text('Metric')),
        ),
        DataColumn(
          label: Expanded(child: Text('AAPL')),
        ),
        DataColumn(
          label: Expanded(child: Text('MSFT')),
        ),
      ],
      rows: widget.firstCompanyMetrics.metrics.keys.map((metric) {
        return DataRow(
          cells: [
            DataCell(Text(metric)),
            DataCell(Text(widget.firstCompanyMetrics.metrics[metric]!)),
            DataCell(Text(widget.secondCompanyMetrics.metrics[metric]!)),
          ],
        );
      }).toList(),
    );
  }
}
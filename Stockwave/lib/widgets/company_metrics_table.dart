import 'package:flutter/material.dart';
import 'package:stockwave/models/company.dart';

class CompanyMetricsTable extends StatefulWidget {
  final Company company;

  const CompanyMetricsTable({
    super.key,
    required this.company,
  });

  @override
  State<CompanyMetricsTable> createState() => _CompanyMetricsTableState();
}

class _CompanyMetricsTableState extends State<CompanyMetricsTable> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      title: const Text('Company Metrics', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: DataTable(
        dividerThickness: 0.1,
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          fontSize: 16,
        ),
        columns: const <DataColumn>[
          DataColumn(label: Expanded(child: Text('Metric'))),
          DataColumn(label: Expanded(child: Text('Value'))),
        ],
        rows: widget.company.metrics.keys.map((metric) {
          return DataRow(
            cells: [
              DataCell(Text(metric)),
              DataCell(Text(widget.company.metrics[metric]!)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
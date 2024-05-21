import 'package:flutter/material.dart';
import 'package:Stockwave/models/company.dart';

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
      title: const Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Text('Company Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      subtitle: DataTable(
        dividerThickness: double.minPositive,
        headingRowHeight: 0,
        horizontalMargin: 0,
        columnSpacing: 20,
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          fontSize: 16,
        ),
        columns: const <DataColumn>[
          DataColumn(label: Expanded(child: Text(''))),
          DataColumn(label: Expanded(child: Text(''))),
        ],
        rows: _buildRows(),
      ),
    );
  }

  List<DataRow> _buildRows() {
    List<DataRow> rows = [];
    List<MapEntry<String, String>> allMetrics =
      widget.company.metrics.entries.map((e) => e).toList();

    for (int i = 0; i < allMetrics.length; i += 2) {
      rows.add(
        DataRow(cells: [
          DataCell(_buildMetricRow(context, allMetrics[i].key, allMetrics[i].value)),
          DataCell(_buildMetricRow(context, allMetrics[i + 1].key, allMetrics[i + 1].value)),
        ])
      );
    }
    return rows;
  }

  Row _buildMetricRow(BuildContext context, String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            key.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
            )),
        Text(value, style: const TextStyle(fontSize: 16))
      ],
    );
  }
}
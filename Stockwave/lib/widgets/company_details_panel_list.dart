import 'package:flutter/material.dart';
import 'package:stockwave/models/company.dart';

import 'item.dart';
import 'key_metrics_table.dart';

class CompanyDetails extends StatefulWidget {
  final Company company;

  const CompanyDetails({
    super.key,
    required this.company,
  });

  
  CompanyDetailsState createState() => CompanyDetailsState();
}

class CompanyDetailsState extends State<CompanyDetails> {
  List<Item> items = <Item>[];

  @override
  void initState() {
    super.initState();

    items = [
      Item(
        title: 'Key Metrics',
        isExpanded: true,
        content: CompanyMetricsTable(
            firstCompany: widget.company,
            secondCompany: widget.company
        ),
      ),
      Item(
        title: 'General Information',
        content: Text('General Details'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items,
    );
  }
}
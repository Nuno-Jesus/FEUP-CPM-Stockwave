import 'package:flutter/material.dart';
import 'package:stockwave/models/company.dart';

import 'item.dart';
import 'key_metrics_table.dart';

class CompanyDetailsPanelList extends StatefulWidget {
  final Company company;

  const CompanyDetailsPanelList({
    super.key,
    required this.company,
  });

  
  CompanyDetailsPanelListState createState() => CompanyDetailsPanelListState();
}

class CompanyDetailsPanelListState extends State<CompanyDetailsPanelList> {
  List<Item> items = <Item>[];

  @override
  void initState() {
    super.initState();

    items = [
      Item(
        title: 'Key Metrics',
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
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          debugPrint('expansionCallback($index, $isExpanded)');
          items[index].isExpanded = isExpanded;
        });
      },
      dividerColor: Theme.of(context).colorScheme.background,
      materialGapSize: 0,
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      children: items.map((Item item) => item.builder(context)).toList(),
    );
  }
}
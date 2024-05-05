import 'package:flutter/material.dart';

import '../models/company.dart';
import 'key_metrics_table.dart';

class Item {
  bool isExpanded;
  final String title;
  final Widget content;

  Item({
    this.isExpanded = false,
    required this.title,
    required this.content,
  });

  ExpansionPanel builder(BuildContext context) {
    debugPrint('Building ${isExpanded ? 'expanded' : 'collapsed'} item: $title');
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20),
          child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                // backgroundColor: Colors.red
              ),
              textAlign: TextAlign.left,
          ),
        );
      },
      backgroundColor: Theme.of(context).colorScheme.background,
      // backgroundColor: Colors.blue,
      body: content,
      isExpanded: isExpanded,
    );
  }
}
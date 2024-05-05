import 'package:flutter/material.dart';

import '../models/company.dart';
import 'key_metrics_table.dart';

class Item extends StatelessWidget{
  bool isExpanded;
  final String title;
  final Widget content;

  Item({
    this.isExpanded = false,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          )
      ),
      subtitle: content,
      isThreeLine: true,
    );
  }
}
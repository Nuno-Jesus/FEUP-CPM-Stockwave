import 'package:flutter/material.dart';
import 'package:stockwave/models/company.dart';

import 'item.dart';
import 'company_metrics_table.dart';

class CompanyGeneralInformation extends StatelessWidget {
  final Company company;

  const CompanyGeneralInformation({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      title: const Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: Text('General Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      subtitle: Text(company['description'], style: const TextStyle(fontSize: 16)),
    );
  }
}
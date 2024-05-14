import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stockwave/widgets/company_card.dart';
import 'package:stockwave/widgets/company_metrics_table.dart';
import 'package:stockwave/widgets/stock_chart.dart';
import 'package:stockwave/models/company.dart';
import 'package:stockwave/models/series.dart';

import '../api.dart';
import '../utils/math.dart';
import '../widgets/company_general_information.dart';
import '../widgets/my_divider.dart';

class OneCompanyView extends StatefulWidget {
  const OneCompanyView({
    super.key, 
    required this.onToggleTheme,
    required this.chosenCompanySymbol,
  });

  final VoidCallback onToggleTheme;
  final String chosenCompanySymbol;

  @override
  State<OneCompanyView> createState() => _OneCompanyViewState();
}

class _OneCompanyViewState extends State<OneCompanyView> {
  List<Series> series = [];
  late Future<List<dynamic>> futures;
  Company company = const Company.empty();
  IconData currentIcon = Icons.dark_mode_outlined;

  @override
  void initState() {
    super.initState();
    futures =  Future.wait([
      fetchCompanyOverview(widget.chosenCompanySymbol),
      fetchDailySeries(widget.chosenCompanySymbol)
    ]);
  }

  void onChangedColorTheme() {
    setState(() {
      widget.onToggleTheme();
      currentIcon = currentIcon == Icons.dark_mode_outlined
          ? Icons.light_mode
          : Icons.dark_mode_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futures,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primaryContainer),
          );
        }
        else {
          debugPrint('Snapshot data ${snapshot.data?[0].toString()}');
          // company = snapshot.data?[0];;
          // String str1 = snapshot.data?[0];
          // String str2 = snapshot.data?[1];

          company = snapshot.data?[0];
          series = snapshot.data?[1];

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: Text(snapshot.data?[0]['name']),
                // title: Text('Company'),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Icon(currentIcon),
                    onPressed: onChangedColorTheme,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    StockChart(firstSeries: series),
                    CompanyCard(
                      company: company,
                      todaySeries: series[0],
                    ),
                    MyDivider(
                      width: MediaQuery.of(context).size.width * 0.75,
                      margin: const EdgeInsets.only(top: 20, bottom: 9),
                    ),
                    CompanyMetricsTable(company: company),
                    CompanyGeneralInformation(company: company),
                    const SizedBox(height: 20),
                  ],
                ),
              )
              // body: Center(
              //     child: Text('Open: ${snapshot.data?[0][0].open} '
              //         'Close: ${snapshot.data?[0][0].close} '
              //         'High: ${snapshot.data?[0][0].high} '
              //         'Low: ${snapshot.data?[0][0].low} '
              //         'Volume: ${snapshot.data?[0][0].volume})'),
              // )
          );
        }
      },
    );
  }
}


// body: Center(
//   child: Text('Company: $str1\nSeries: $str2')
// )
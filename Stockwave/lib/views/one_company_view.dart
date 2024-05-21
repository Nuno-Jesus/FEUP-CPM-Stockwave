import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Stockwave/widgets/company_candle_stock_chart.dart';
import 'package:Stockwave/widgets/company_card.dart';
import 'package:Stockwave/widgets/company_metrics_table.dart';
import 'package:Stockwave/widgets/company_spline_stock_chart.dart';
import 'package:Stockwave/models/company.dart';
import 'package:Stockwave/models/series.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api.dart';
import '../utils/math.dart';
import '../widgets/company_general_information.dart';
import '../widgets/my_divider.dart';

class OneCompanyView extends StatefulWidget {
  const OneCompanyView({
    super.key, 
    required this.onToggleTheme,
    required this.chosenSymbol,
  });

  final VoidCallback onToggleTheme;
  final String chosenSymbol;

  @override
  State<OneCompanyView> createState() => _OneCompanyViewState();
}

class _OneCompanyViewState extends State<OneCompanyView> {
  late Future<List<dynamic>> futures;
  List<Series> series = [];
  late Company company;
  
  IconData themeIcon = Icons.dark_mode_outlined;
  IconData chartIcon = Icons.show_chart_outlined;

  @override
  void initState() {
    super.initState();
    futures = Future.wait([
      fetchCompanyOverview(widget.chosenSymbol),
      fetchDailySeries(widget.chosenSymbol)
    ]);
  }

  void onChangedColorTheme() {
    setState(() {
      widget.onToggleTheme();
      themeIcon = themeIcon == Icons.dark_mode_outlined
          ? Icons.light_mode
          : Icons.dark_mode_outlined;
    });
  }
  
  void onChangedChartType() {
    setState(() {
      chartIcon = chartIcon == Icons.candlestick_chart_outlined
          ? Icons.show_chart_outlined
          : Icons.candlestick_chart_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futures,
      builder: (context, snapshot) {
        print('Snapshot connection state: ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primaryContainer),
          );
        } else if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
          print('Snapshot has no data');
          return Center(child: Text('No data available'));
        } else {
          print('Snapshot data: ${snapshot.data}');
          company = snapshot.data![0] as Company;
          series = snapshot.data![1] as List<Series>;

          return _buildView();
      }
    });
  }

  Widget _buildView() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(company['name']),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(chartIcon),
              onPressed: onChangedChartType,
            ),
            IconButton(
              icon: Icon(themeIcon),
              onPressed: onChangedColorTheme,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              chartIcon == Icons.show_chart_outlined
                  ? CompanyCandleStockChart(firstSeries: series, firstCompany: company)
                  : CompanySplineStockChart(firstSeries: series, firstCompany: company),
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
    );
  }
}
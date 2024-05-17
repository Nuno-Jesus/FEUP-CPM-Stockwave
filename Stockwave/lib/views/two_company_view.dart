import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stockwave/widgets/company_metrics_table.dart';
import 'package:stockwave/widgets/my_divider.dart';
import 'package:stockwave/widgets/company_card.dart';
import 'package:stockwave/widgets/company_general_information.dart';
import 'package:stockwave/widgets/company_spline_stock_chart.dart';
import 'package:stockwave/models/company.dart';
import 'package:stockwave/models/series.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../api.dart';

class TwoCompanyView extends StatefulWidget {
  const TwoCompanyView({
    super.key, 
    required this.onToggleTheme,
    required this.firstChosenSymbol,
    required this.secondChosenSymbol
  });

  final VoidCallback onToggleTheme;
  final String firstChosenSymbol;
  final String secondChosenSymbol;

  @override
  State<TwoCompanyView> createState() => _TwoCompanyViewState();
}

class _TwoCompanyViewState extends State<TwoCompanyView> {
  late Future<List<dynamic>> futures;
  List<Series> firstSeries = [];
  List<Series> secondSeries = [];
  Company firstCompany = const Company.empty();
  Company secondCompany = const Company.empty();
  late Company selectedCompany;
  IconData currentIcon = Icons.dark_mode_outlined;

  @override
  @override
  void initState() {
    super.initState();
    futures = Future.wait([
      fetchCompanyOverview(widget.firstChosenSymbol),
      fetchDailySeries(widget.firstChosenSymbol),
      fetchCompanyOverview(widget.secondChosenSymbol),
      fetchDailySeries(widget.secondChosenSymbol),
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
          firstCompany = snapshot.data![0];
          firstSeries = snapshot.data![1];
          secondCompany = snapshot.data![2];
          secondSeries = snapshot.data![3];
          selectedCompany = firstCompany;

          return _buildView([firstCompany, secondCompany]);
        }
      },
    );
  }

  Widget _buildView(List<Company> companies){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
              '${firstCompany['symbol']} vs ${secondCompany['symbol']}',
              style: TextStyle(fontSize: 19)
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)
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
                CompanySplineStockChart(
                    firstSeries: firstSeries,
                    firstCompany: firstCompany,
                    secondSeries: secondSeries,
                    secondCompany: secondCompany
                ),
                SizedBox(
                  height: 160,
                  child: ScrollSnapList(
                    onItemFocus: (int index) {
                      debugPrint('Item $index has come into view');
                      setState(() {
                        selectedCompany = companies[index];
                      });
                    },
                    itemSize: MediaQuery.of(context).size.width,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CompanyCard(
                          company: companies[index],
                          todaySeries: index == 0 ? firstSeries[0] : secondSeries[0],
                          isSecondary: index == 1,
                        ),
                      );
                    },
                    itemCount: companies.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                MyDivider(
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: const EdgeInsets.only(top: 20, bottom: 9),
                ),
                CompanyMetricsTable(company: selectedCompany),
                CompanyGeneralInformation(company: selectedCompany),
                const SizedBox(height: 20),
              ]
          ),
        )
    );
  }
}
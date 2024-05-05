import 'package:flutter/material.dart';
import 'package:stockwave/widgets/my_divider.dart';
import 'package:stockwave/widgets/company_card.dart';
import 'package:stockwave/widgets/company_details_panel_list.dart';
import 'package:stockwave/widgets/stock_chart.dart';
import 'package:stockwave/models/company.dart';
import 'package:stockwave/models/series.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TwoCompanyView extends StatefulWidget {
  const TwoCompanyView({
    super.key, 
    required this.onToggleTheme,
    required this.first,
    required this.second
  });

  final VoidCallback onToggleTheme;
  final Map<String, dynamic> first;
  final Map<String, dynamic> second;
  
  @override
  State<TwoCompanyView> createState() => _TwoCompanyViewState();
}

class _TwoCompanyViewState extends State<TwoCompanyView> {
  List<Series> firstSeries = [];
  List<Series> secondSeries = [];
  late Company firstCompany;
  late Company secondCompany;
  IconData currentIcon = Icons.dark_mode_outlined;

  @override
  void initState() {
    super.initState();

    _loadSeries();
    _loadCompanyMetrics();
  }

  Future _loadSeries() async {
    // var response = await fetchDailySeries(firstCompany['symbol']);
    // var jsonData = jsonDecode(response.body);

    // debugPrint('Loaded JSON: $jsonData');

    // for (var entry in jsonData['Time Series (Daily)']) {
    //   series.add(Series.fromJson(entry.key, entry.value));
    // }
    firstSeries.add(const Series(open: 40.0, close: 20.0, high: 3.0, low: 0.5, volume: 1000.0, date: '2022-01-10'));
    firstSeries.add(const Series(open: 23.0, close: 33.0, high: 4.0, low: 1.5, volume: 2000.0, date: '2022-01-11'));
    firstSeries.add(const Series(open: 15.0, close: 12.0, high: 5.0, low: 2.5, volume: 3000.0, date: '2022-01-12'));
    firstSeries.add(const Series(open: 66.0, close: 50.0, high: 6.0, low: 3.5, volume: 4000.0, date: '2022-01-13'));
    firstSeries.add(const Series(open: 78.0, close: 55.0, high: 7.0, low: 4.5, volume: 5000.0, date: '2022-01-14'));
    firstSeries.add(const Series(open: 32.0, close: 60.0, high: 8.0, low: 5.5, volume: 6000.0, date: '2022-01-15'));
    firstSeries.add(const Series(open: 25.0, close: 13.0, high: 9.0, low: 6.5, volume: 7000.0, date: '2022-01-16'));
    firstSeries.add(const Series(open: 64.0, close: 35.0, high: 10.0, low: 7.5, volume: 8000.0, date: '2022-01-17'));

    secondSeries.add(const Series(open: 40.0, close: 20.0, high: 3.0, low: 0.5, volume: 1000.0, date: '2022-01-10'));
    secondSeries.add(const Series(open: 23.0, close: 33.0, high: 4.0, low: 1.5, volume: 2000.0, date: '2022-01-11'));
    secondSeries.add(const Series(open: 15.0, close: 12.0, high: 5.0, low: 2.5, volume: 3000.0, date: '2022-01-12'));
    secondSeries.add(const Series(open: 66.0, close: 50.0, high: 6.0, low: 3.5, volume: 4000.0, date: '2022-01-13'));
    secondSeries.add(const Series(open: 78.0, close: 55.0, high: 7.0, low: 4.5, volume: 5000.0, date: '2022-01-14'));
    secondSeries.add(const Series(open: 32.0, close: 60.0, high: 8.0, low: 5.5, volume: 6000.0, date: '2022-01-15'));
    secondSeries.add(const Series(open: 25.0, close: 13.0, high: 9.0, low: 6.5, volume: 7000.0, date: '2022-01-16'));
    secondSeries.add(const Series(open: 64.0, close: 35.0, high: 10.0, low: 7.5, volume: 8000.0, date: '2022-01-17'));


    debugPrint('Loaded series: ${firstSeries.length}');
    debugPrint(firstSeries[0].toString());
  }

  Future _loadCompanyMetrics() async {
    firstCompany = const Company(metrics: {
      'Market Cap': '2.46T',
      'Revenue': '365.7B',
      'Dividend Yield': '0.52%',
      'P/E Ratio': '28.15',
      'EPS': '5.1',
      'Beta': '1.2',
    },
    details: {
      'name': 'Apple Inc.',
      'symbol': 'AAPL',
      'icon': Icons.apple,
    });
    
    secondCompany = const Company(metrics: {
      'Market Cap': '2.46T',
      'Revenue': '365.7B',
      'Dividend Yield': '0.52%',
      'P/E Ratio': '28.15',
      'EPS': '5.1',
      'Beta': '1.2',
    },
    details: {
      'name': 'Microsoft Corporation',
      'symbol': 'MSFT',
      'icon': Icons.window_sharp,
    });
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
    List<Company> companies = [firstCompany, secondCompany];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('${firstCompany['name']} vs ${secondCompany['name']}'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              debugPrint('Back button pressed');
            },
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
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StockChart(series: firstSeries),
            SizedBox(
              height: 1000,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CompanyCard(
                        company: companies[index],
                        todaySeries: firstSeries[index],
                        isSecondary: index == 1,
                      ),
                      MyDivider(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      CompanyDetails(company: companies[index]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

// body: SingleChildScrollView(
//   child: Column(
//     children: [
//       CompanyCard(
//           company: firstCompany,
//           todaySeries: firstSeries[0],
//       ),
//       CompanyCard(
//           company: secondCompany,
//           todaySeries: firstSeries[1],
//           isSecondary: true,
//       ),
//       StockChart(series: firstSeries),
//       CompanyDetailsPanelList(company: firstCompany),
//       // CompanyMetricsTable(
//       //     firstCompany: firstCompany,
//       //     secondCompany: secondCompany
//       // ),
//       const SizedBox(height: 20.0)
//     ],
//   ),
// )
import 'package:flutter/material.dart';
import 'package:stockwave/widgets/company_card.dart';
import 'package:stockwave/widgets/company_metrics_table.dart';
import 'package:stockwave/widgets/stock_chart.dart';
import 'package:stockwave/models/company.dart';
import 'package:stockwave/models/series.dart';

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
  late Company company;
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
    series.add(Series(open: 40.0, close: 20.0, high: 3.0, low: 0.5, volume: 1000.0, date: '2022-01-10'));
    series.add(Series(open: 23.0, close: 33.0, high: 4.0, low: 1.5, volume: 2000.0, date: '2022-01-11'));
    series.add(Series(open: 15.0, close: 12.0, high: 5.0, low: 2.5, volume: 3000.0, date: '2022-01-12'));
    series.add(Series(open: 66.0, close: 50.0, high: 6.0, low: 3.5, volume: 4000.0, date: '2022-01-13'));
    series.add(Series(open: 78.0, close: 55.0, high: 7.0, low: 4.5, volume: 5000.0, date: '2022-01-14'));
    series.add(Series(open: 32.0, close: 60.0, high: 8.0, low: 5.5, volume: 6000.0, date: '2022-01-15'));
    series.add(Series(open: 25.0, close: 13.0, high: 9.0, low: 6.5, volume: 7000.0, date: '2022-01-16'));
    series.add(Series(open: 64.0, close: 35.0, high: 10.0, low: 7.5, volume: 8000.0, date: '2022-01-17'));


    debugPrint('Loaded series: ${series.length}');
    debugPrint(series[0].toString());
  }

  Future _loadCompanyMetrics() async {
    company = const Company(metrics: {
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
      'description' : 'Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. It also sells various related services. The company offers iPhone, a line of smartphones; Mac, a line of personal computers; iPad, a line of multi-purpose tablets; and wearables, home, and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, HomePod, iPod touch, and other Apple-branded and third-party accessories. It also provides AppleCare support services; cloud services store services; and operates various platforms, including the App Store, that allow customers to discover and download applications and digital content, such as books, music, video, games, and podcasts. In addition, the company offers various services, such as Apple Arcade, a game subscription service; Apple Music, which offers users a curated listening experience with on-demand radio stations; Apple News+, a subscription news and magazine service; Apple TV+, which offers exclusive original content; Apple Card, a co-branded credit card; and Apple Pay, a cashless payment service, as well as licenses its intellectual property. The company serves consumers, and small and mid-sized businesses; and the education, enterprise, and government markets. It sells and delivers third-party applications for its products through the App Store. The company also sells its products through its retail and online stores, and direct sales force; and third-party cellular network carriers, wholesalers, retailers, and resellers. Apple Inc. was founded in 1977 and is headquartered in Cupertino, California.',
      'icon': Icons.apple,
    });
  }


  @override
  Widget build(BuildContext context) {
    void onChangedColorTheme() {
      setState(() {
        widget.onToggleTheme();
        currentIcon = currentIcon == Icons.dark_mode_outlined
            ? Icons.light_mode
            : Icons.dark_mode_outlined;
      });
    }

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
              icon: Icon(currentIcon),
              onPressed: onChangedColorTheme,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                StockChart(series: series),
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
                SizedBox(height: 20),
              ]
          ),
        )
    );
  }
}
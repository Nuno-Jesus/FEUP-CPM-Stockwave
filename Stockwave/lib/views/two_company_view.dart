import 'package:flutter/material.dart';
import 'package:stockwave/widgets/company_metrics_table.dart';
import 'package:stockwave/widgets/my_divider.dart';
import 'package:stockwave/widgets/company_card.dart';
import 'package:stockwave/widgets/company_general_information.dart';
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
  late Company selectedCompany;
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
      'description' : 'Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. It also sells various related services. The company offers iPhone, a line of smartphones; Mac, a line of personal computers; iPad, a line of multi-purpose tablets; and wearables, home, and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, HomePod, iPod touch, and other Apple-branded and third-party accessories. It also provides AppleCare support services; cloud services store services; and operates various platforms, including the App Store, that allow customers to discover and download applications and digital content, such as books, music, video, games, and podcasts. In addition, the company offers various services, such as Apple Arcade, a game subscription service; Apple Music, which offers users a curated listening experience with on-demand radio stations; Apple News+, a subscription news and magazine service; Apple TV+, which offers exclusive original content; Apple Card, a co-branded credit card; and Apple Pay, a cashless payment service, as well as licenses its intellectual property. The company serves consumers, and small and mid-sized businesses; and the education, enterprise, and government markets. It sells and delivers third-party applications for its products through the App Store. The company also sells its products through its retail and online stores, and direct sales force; and third-party cellular network carriers, wholesalers, retailers, and resellers. Apple Inc. was founded in 1977 and is headquartered in Cupertino, California.',
      'icon': Icons.apple,
    });
    
    secondCompany = const Company(//fill with Microsoftmetrics
      metrics: {
      'Market Cap': '2.98T',
      'Revenue': '400.7B',
      'Dividend Yield': '1.52%',
      'P/E Ratio': '29.15',
      'EPS': '4.1',
      'Beta': '2.2',
    },
    details: {
      'name': 'Microsoft Corporation',
      'symbol': 'MSFT',
      'description' : 'Microsoft Corporation develops, licenses, and supports software, services, devices, and solutions worldwide. Its Productivity and Business Processes segment offers Office, Exchange, SharePoint, Microsoft Teams, Office 365 Security and Compliance, and Skype for Business, as well as related Client Access Licenses (CAL); Skype, Outlook.com, and OneDrive; LinkedIn that includes Talent, Learning, Sales, and Marketing solutions, as well as premium subscriptions; and Dynamics 365, a set of cloud-based and on-premises business solutions for small and medium businesses, large organizations, and divisions of enterprises. Its Intelligent Cloud segment licenses SQL and Windows Servers, Visual Studio, System Center, and related CALs; GitHub that provides a collaboration platform and code hosting service for developers; and Azure, a cloud platform. It also provides support services and Microsoft consulting services to assist customers in developing, deploying, and managing Microsoft server and desktop solutions; and training and certification to developers and IT professionals on various Microsoft products. Its More Personal Computing segment offers Windows OEM licensing and other non-volume licensing of the Windows operating system; Windows Commercial comprising volume licensing of the Windows operating system, Windows cloud services, and other Windows commercial offerings; patent licensing; Windows Internet of Things; and MSN advertising. It also provides Microsoft Surface, PC accessories, and other intelligent devices; Gaming, including Xbox hardware, and Xbox software and services; video games and third-party video game royalties; and Search, including Bing and Microsoft advertising. It sells its products through OEMs, distributors, and resellers; and directly through digital marketplaces, online stores, and retail stores. The company was founded in 1975 and is headquartered in Redmond, Washington.',
      'icon': Icons.window_sharp,
    });

    selectedCompany = firstCompany;
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
          children: [
            StockChart(series: firstSeries),
            SizedBox(
              height: 155,
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
            SizedBox(height: 20),
          ]
        ),
      )
    );
  }
}
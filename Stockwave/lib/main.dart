import 'package:flutter/material.dart';
import 'package:stockwave/api.dart';
import 'package:stockwave/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockwave/widgets/stock_chart.dart';
import 'dart:convert';

import 'package:stockwave/widgets/company_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  
  void _toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.fredoka().fontFamily,
        colorScheme: lightColorTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.fredoka().fontFamily,
        colorScheme: darkColorTheme,
      ),
      themeMode: themeMode,
      home: MyHomePage(onToggleTheme: _toggleTheme),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.onToggleTheme});
  
  final VoidCallback onToggleTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Series> series = [];
  IconData currentIcon = Icons.dark_mode_outlined;
  
  @override
  void initState() {
    super.initState();

    _loadSeries();
  }

  Future _loadSeries() async {
    // var response = await fetchDailySeries('AAPL');
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


  @override
  Widget build(BuildContext context) {

    void onChangedColorTheme() {
      setState(() {
        widget.onToggleTheme();
        currentIcon = currentIcon == Icons.dark_mode_outlined ?
          Icons.light_mode :
          Icons.dark_mode_outlined;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Apple vs Microsoft'),
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
        body: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CompanyCard(
                  name: 'Apple Inc.',
                  nasdaq: 'AAPL',
                  icon: Icons.apple,
                  todaySeries: series[0],
                  cardColor: Theme.of(context).colorScheme.primaryContainer,
                  textColor: Theme.of(context).colorScheme.onPrimaryContainer
              ),
              CompanyCard(
                  name: 'Microsoft Inc.',
                  nasdaq: 'MSFT',
                  icon: Icons.desktop_windows,
                  todaySeries: series[1],
                  cardColor: Theme.of(context).colorScheme.secondaryContainer,
                  textColor: Theme.of(context).colorScheme.onSecondaryContainer
              ),
              StockChart(series: series)
            ],
          ),
        )
    );
  }
}

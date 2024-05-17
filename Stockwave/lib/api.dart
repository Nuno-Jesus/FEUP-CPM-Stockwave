import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stockwave/models/series.dart';
import 'package:stockwave/utils/math.dart';

import 'models/company.dart';

// const String apiKey = 'XYEF90V50KRJJYD0';
const String apiKey = 'SE8XFCS9V4LJRN8Q';
const String host = 'https://www.alphavantage.co';

const Map<String, String> companies = {
  'AAPL': 'Apple Inc.',
  'MSFT': 'Microsoft Corporation',
  'AMZN': 'Amazon.com Inc.',
  'GOOGL': 'Alphabet Inc.',
  'FB': 'Meta Platforms Inc.',
  'IBM': 'International Business Machines Corporation',
  'INTC': 'Intel Corporation',
  'HPQ': 'HP Inc.',
  'ORCL': 'Oracle Corporation',
  'X': 'United States Steel Corporation',
};

Future<List<Series>> fetchDailySeries(String symbol) async {
  List<Series> series = [];

  series.add(const Series(open: 40.0, close: 20.0, high: 3.0, low: 0.5, volume: 1000.0, date: '2022-01-10'));
  series.add(const Series(open: 23.0, close: 33.0, high: 4.0, low: 1.5, volume: 2000.0, date: '2022-01-11'));
  series.add(const Series(open: 15.0, close: 12.0, high: 5.0, low: 2.5, volume: 3000.0, date: '2022-01-12'));
  series.add(const Series(open: 66.0, close: 50.0, high: 6.0, low: 3.5, volume: 4000.0, date: '2022-01-13'));
  series.add(const Series(open: 78.0, close: 55.0, high: 7.0, low: 4.5, volume: 5000.0, date: '2022-01-14'));
  series.add(const Series(open: 32.0, close: 60.0, high: 8.0, low: 5.5, volume: 6000.0, date: '2022-01-15'));
  series.add(const Series(open: 25.0, close: 13.0, high: 9.0, low: 6.5, volume: 7000.0, date: '2022-01-16'));
  series.add(const Series(open: 64.0, close: 35.0, high: 10.0, low: 7.5, volume: 8000.0, date: '2022-01-17'));

  return series;

  final response = await http
      .get(Uri.parse('$host/query?'
      'function=TIME_SERIES_DAILY'
      '&symbol=$symbol'
      '&apikey=$apiKey'));

  // debugPrint('Response: ${response.body}');

  if (response.statusCode == 200) {
    final entries = jsonDecode(response.body)['Time Series (Daily)'].entries;
    // debugPrint('Entries: $entries');
    List<Series> series = [];

    for (var entry in entries) {
      series.add(Series(
        date: entry.key,
        open: double.parse(entry.value['1. open']),
        high: double.parse(entry.value['2. high']),
        low: double.parse(entry.value['3. low']),
        close: double.parse(entry.value['4. close']),
        volume: double.parse(entry.value['5. volume']),
      ));
    }
    return (series);
  } else {
    throw Exception('Failed to load series');
  }
}

Future<Company> fetchCompanyOverview(String symbol) async {
  return Company(metrics: {
    'Market Cap': 'N/A',
    'Revenue': 'N/A',
    'Dividend Yield': 'N/A',
    'P/E Ratio': 'N/A',
    'EPS': 'N/A',
    'Beta': 'N/A',
  },
  details: {
    'name': companies[symbol]!,
    'symbol': symbol,
    'description': 'N/A',
  });

  final response = await http
      .get(Uri.parse('$host/query?'
      'function=OVERVIEW'
      '&symbol=$symbol'
      '&apikey=$apiKey'));

  debugPrint('Response: ${response.body}');
  debugPrint('Response Status Code ${response.statusCode}');
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    Company company = Company(metrics: {
      'Market Cap': reduceDollars(data['MarketCapitalization']),
      'Revenue': reduceDollars(data['RevenueTTM']),
      'Dividend Yield': reduceDividendYield(data['DividendYield']),
      'P/E Ratio': data['PERatio'],
      'EPS': data['EPS'],
      'Beta': data['Beta'],
    },
    details: {
      'name': data['Name'],
      'symbol': data['Symbol'],
      'description' : data['Description'],
    });

    debugPrint('Company overview: ${company.toString()}');

    return company;
  } else {
    throw Exception('Failed to load company overview');
  }
}

Future<String> dummyFetchDailySeries(String symbol) async {
  return Future.delayed(const Duration(seconds: 2),
          () => "Daily series for $symbol");
}

Future<String> dummyFetchCompanyOverview(String symbol) async {
  return Future.delayed(const Duration(seconds: 3),
          () => "Company overview for $symbol");
}


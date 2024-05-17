import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stockwave/models/series.dart';
import 'package:stockwave/utils/math.dart';

import 'models/company.dart';

// const String apiKey = 'XYEF90V50KRJJYD0';
const String apiKey = 'SE8XFCS9V4LJRN8Q';
const String host = 'https://www.alphavantage.co';

const Map<String, List<dynamic>> companies = {
  'AAPL': ['Apple Inc.', Icons.apple],
  'MSFT': ['Microsoft Corporation', Icons.computer],
  'AMZN': ['Amazon.com Inc.', Icons.shopping_cart],
  'GOOGL': ['Alphabet Inc.', Icons.search],
  'FB': ['Meta Platforms Inc.', Icons.facebook],
  'IBM': ['International Business Machines Corporation', Icons.computer],
  'INTC': ['Intel Corporation', Icons.memory],
  'HPQ': ['HP Inc.', Icons.print],
  'ORCL': ['Oracle Corporation', Icons.data_usage],
  'X': ['United States Steel Corporation', Icons.close],
};

Future<List<Series>> fetchDailySeries(String symbol) async {
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
      'icon': companies[data['Symbol']]![1],
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


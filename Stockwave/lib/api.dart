import 'dart:math';

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
  'TSLA': 'Tesla Inc.',
};

Future<List<Series>> fetchDailySeries(String symbol) async {
  List<Series> series = [];

  for (int i = 0; i < 7; i++)
    series.add(
      Series(
        date: '2022-01-0${i + 1}',
        open: Random.secure().nextDouble() * 100,
        high: Random.secure().nextDouble() * 100,
        low: Random.secure().nextDouble() * 100,
        close: Random.secure().nextDouble() * 100,
        volume: Random.secure().nextDouble() * 100,
      )
    );

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
    return [];
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

  debugPrint('URL: ${host}/query?function=OVERVIEW&symbol=${symbol}&apikey=${apiKey}')
  debugPrint('Response Status Code ${response.statusCode}');
  debugPrint('Response: ${response.body}');
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
    return const Company.empty();
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


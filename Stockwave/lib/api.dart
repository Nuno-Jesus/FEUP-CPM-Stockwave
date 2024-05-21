
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:Stockwave/models/series.dart';
import 'package:Stockwave/utils/math.dart';

import 'models/company.dart';

const String apiKey = 'XYEF90V50KRJJYD0';
// const String apiKey = 'SE8XFCS9V4LJRN8Q';
const String host = 'https://www.alphavantage.co';

const Map<String, String> companies = {
  'AAPL': 'Apple Inc.',
  'MSFT': 'Microsoft Corporation',
  'AMZN': 'Amazon.com Inc.',
  'NVDA': 'NVIDIA Corporation',
  'FB': 'Meta Platforms Inc.',
  'IBM': 'International Business Machines Corporation',
  'INTC': 'Intel Corporation',
  'HPQ': 'HP Inc.',
  'DIS': 'The Walt Disney Company',
  'TSLA': 'Tesla Inc.',
};

Future<List<Series>> fetchDailySeries(String symbol) async {
  List<Series> series = [];

  // for (int i = 0; i < 7; i++)
  //   series.add(Series.generate(i));
  // return series;

  final response = await http
      .get(Uri.parse('$host/query?'
      'function=TIME_SERIES_DAILY'
      '&symbol=$symbol'
      '&apikey=$apiKey'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['Information'] != "") {
      for (int i = 0; i < 7; i++) {
        series.add(Series.generate(i));
      }
      return series;
    }

    final entries = data['Time Series (Daily)'].entries;
    for (var entry in entries) {
      series.add(Series.fromJson(entry.key, entry.value));
      if (series.length == 7) {
        break;
      }
    }
    debugPrint('Series: $series');
    return (series);
  } else {
    for (int i = 0; i < 7; i++) {
      series.add(Series.generate(i));
    }
    return series;
  }
}

Future<Company> fetchCompanyOverview(String symbol) async {
  // return Company.dummy(symbol);
  final response = await http
      .get(Uri.parse('$host/query?'
      'function=OVERVIEW'
      '&symbol=$symbol'
      '&apikey=$apiKey'));

  debugPrint('URL: $host/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey');
  debugPrint('Response Status Code ${response.statusCode}');
  debugPrint('Response: ${response.body}');
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['Information'] != "") {
      return (Company.dummy(symbol));
    }
    debugPrint('Data: $data');

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
    return Company.dummy(symbol);
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


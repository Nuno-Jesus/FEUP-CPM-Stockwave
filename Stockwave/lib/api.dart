import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// const String apiKey = 'XYEF90V50KRJJYD0';
const String apiKey = 'SE8XFCS9V4LJRN8Q';

const String host = 'https://www.alphavantage.co';
const Map<String, IconData> companies = {
  'AAPL': Icons.apple,
  'IBM': Icons.computer,
  'HPQ': Icons.print,
  'MSFT': Icons.window,
  'ORCL': Icons.data_usage,
  'GOOGL': Icons.search,
  'FB': Icons.facebook,
  'X': Icons.close,
  'INTC': Icons.memory,
  'AMZN': Icons.shopping_cart,
};

Future fetchDailySeries(String symbol) async {
  final response = await http
      .get(Uri.parse('$host/query?'
        'function=TIME_SERIES_DAILY'
        '&symbol=$symbol'
        '&apikey=$apiKey'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['Time Series (Daily)'].entries;
  } else {
    throw Exception('Failed to load series');
  }
}

Future fetchCompanyOverview(String symbol) async {
  final response = await http
      .get(Uri.parse('$host/query?'
      'function=OVERVIEW'
      '&symbol=$symbol'
      '&apikey=$apiKey'));

  debugPrint('$host/query?'
      'function=OVERVIEW'
      '&symbol=$symbol'
      '&apikey=$apiKey');

  if (response.statusCode == 200) {
    debugPrint(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load company overview');
  }
}


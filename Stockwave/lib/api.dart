import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = 'XYEF90V50KRJJYD0';
const String host = 'https://www.alphavantage.co';

Future fetchDailySeries(String company) async {
  final response = await http
      .get(Uri.parse('$host/query?'
        'function=TIME_SERIES_DAILY'
        '&symbol=$company'
        '&apikey=$apiKey'));

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load series');
  }
}


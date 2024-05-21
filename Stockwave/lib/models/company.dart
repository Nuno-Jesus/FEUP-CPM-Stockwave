import 'dart:math';

class Company {
  final Map<String, String> metrics;
  final Map<String, String> details;

  const Company({
    required this.metrics,
    required this.details,
  });

  const Company.empty() :
        metrics = const {
          'Market Cap': 'N/A',
          'Revenue': 'N/A',
          'Dividend Yield': 'N/A',
          'P/E Ratio': 'N/A',
          'EPS': 'N/A',
          'Beta': 'N/A',
        },
        details = const {
          'name': 'N/A',
          'symbol': 'N/A',
          'description': 'N/A',
        };


  Company.dummy(String symbol) :
        metrics = {
          'Market Cap': (Random.secure().nextDouble() * 300).toStringAsFixed(2),
          'Revenue': (Random.secure().nextDouble() * 100).toStringAsFixed(2),
          'Dividend Yield': (Random.secure().nextDouble() * 100).toStringAsFixed(2),
          'P/E Ratio': (Random.secure().nextDouble() * 50).toStringAsFixed(2),
          'EPS': (Random.secure().nextDouble() * 30).toStringAsFixed(2),
          'Beta': (Random.secure().nextDouble() * 15).toStringAsFixed(2),
        },
        details = {
          'name': '$symbol N/A',
          'symbol': symbol,
          'description': '$symbol N/A',
        };

  dynamic operator [](String key){
    if (metrics.containsKey(key)) {
      return metrics[key]!;
    } else {
      return details[key]!;
    }
  }

  @override
  String toString() {
    String result = '';
    metrics.forEach((key, value) {
      result += '$key: $value\n';
    });
    details.forEach((key, value) {
      result += '$key: $value\n';
    });
    return 'Company: $result';
  }
}
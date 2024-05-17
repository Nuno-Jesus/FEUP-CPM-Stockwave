class Company {
  final Map<String, String> metrics;
  final Map<String, dynamic> details;

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
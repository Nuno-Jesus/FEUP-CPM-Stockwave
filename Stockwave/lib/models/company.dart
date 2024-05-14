class Company {
  final Map<String, String> metrics;
  final Map<String, dynamic> details;

  const Company({
    required this.metrics,
    required this.details,
  });

  const Company.empty() : metrics = const {}, details = const {};

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
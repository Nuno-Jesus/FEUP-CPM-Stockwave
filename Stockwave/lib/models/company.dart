class Company {
  final Map<String, String> metrics;
  final Map<String, dynamic> details;

  const Company({
    required this.metrics,
    required this.details,
  });

  dynamic operator [](String key){
    if (metrics.containsKey(key)) {
      return metrics[key]!;
    } else {
      return details[key]!;
    }
  }
}
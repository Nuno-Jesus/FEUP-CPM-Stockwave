class CompanyMetrics {
  final Map<String, String> metrics;

  const CompanyMetrics({
    required this.metrics,
  });

  factory CompanyMetrics.fromJson(Map<String, dynamic> json) {
    return CompanyMetrics(
      metrics: json.map((key, value) => MapEntry(key, value.toString())),
    );
  }
}

class Series {
  final double open;
  final double close;
  final double high;
  final double low;
  final double volume;
  final String date;

  const Series({
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.volume,
    required this.date,
  });

  factory Series.fromJson(String date, Map<String, dynamic> json) {
    return switch (json) {
      {
      '1. open': String open,
      '2. high': String high,
      '3. low': String low,
      '4. close': String close,
      '5. volume': String volume,
      } =>
          Series(
            open: double.parse(open),
            close: double.parse(close),
            high: double.parse(high),
            low: double.parse(low),
            volume: double.parse(volume),
            date: date,
          ),
      _ => throw const FormatException('Failed to load series.'),
    };
  }

  @override
  String toString() {
    return 'Series{ date: $date, open: $open, close: $close, high: $high, low: $low, volume: $volume }';
  }
}
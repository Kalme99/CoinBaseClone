class CoinData {
  final num time;
  final num high;
  final num low;
  final num open;
  final num volumefrom;
  final num volumeto;
  final num close;
  final String conversionType;
  final String conversionSymbol;

  CoinData({
    required this.time,
    required this.high,
    required this.low,
    required this.open,
    required this.volumefrom,
    required this.volumeto,
    required this.close,
    required this.conversionType,
    required this.conversionSymbol,
  });

  factory CoinData.fromMap(Map<String, dynamic> json) {
    return CoinData(
      time: json['time'] ?? 0,
      high: json['high'] ?? 0.0,
      low: json['low'] ?? 0.0,
      open: json['open'] ?? 0.0,
      volumefrom: json['volumefrom'] ?? 0.0,
      volumeto: json['volumeto'] ?? 0.0,
      close: json['close'] ?? 0.0,
      conversionType: json['conversionType'] ?? "",
      conversionSymbol: json['conversionSymbol'] ?? "",
    );
  }
}

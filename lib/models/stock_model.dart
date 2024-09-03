
class Stock {
  final String symbol;
  final dynamic currentPrice;
  final dynamic dayLow;
  final dynamic dayHigh;
  final dynamic yearLow;
  final dynamic yearHigh;
  final dynamic changePercentage;

  Stock({
    required this.symbol,
    required this.currentPrice,
    required this.dayLow,
    required this.dayHigh,
    required this.yearLow,
    required this.yearHigh,
    required this.changePercentage,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      currentPrice: json['price'],
      dayLow: json['dayLow'],
      dayHigh: json['dayHigh'],
      yearLow: json['yearLow'],
      yearHigh: json['yearHigh'],
      changePercentage: json['changesPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'currentPrice': currentPrice,
      'dayLow': dayLow,
      'dayHigh': dayHigh,
      'yearLow': yearLow,
      'yearHigh': yearHigh,
      'changePercentage': changePercentage,
    };
  }
}

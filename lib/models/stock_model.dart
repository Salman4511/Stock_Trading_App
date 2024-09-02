class PricePoint {
  final int time;
  final double price;

  PricePoint({required this.time, required this.price});

  factory PricePoint.fromJson(Map<String, dynamic> json) {
    return PricePoint(
      time: json['time'],
      price: json['price'],
    );
  }
}

class Stock {
  final String symbol;
  final double currentPrice;
  final double changePercentage;
  final List<PricePoint> priceHistory;

  Stock({
    required this.symbol,
    required this.currentPrice,
    required this.changePercentage,
    required this.priceHistory,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      currentPrice: json['currentPrice'],
      changePercentage: json['changePercentage'],
      priceHistory: (json['priceHistory'] as List)
          .map((e) => PricePoint.fromJson(e))
          .toList(),
    );
  }
}

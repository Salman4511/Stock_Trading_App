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
}

class PricePoint {
  final int time;
  final double price;

  PricePoint({
    required this.time,
    required this.price,
  });
}

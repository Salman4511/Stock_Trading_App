import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_model.dart';

class StockService {
  static const String apiKey = 'O6BANWNC0B393EQC';
  final String baseUrl = 'https://www.alphavantage.co/query';

  Future<Stock> fetchStock(String symbol) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=5min&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final timeSeries = data['Time Series (5min)'] as Map<String, dynamic>;

      final priceHistory = timeSeries.entries.map((entry) {
        final time = DateTime.parse(entry.key).millisecondsSinceEpoch;
        final priceData = entry.value as Map<String, dynamic>;
        return PricePoint(
          time: time,
          price: double.parse(priceData['4. close']),
        );
      }).toList();

      if (priceHistory.isNotEmpty) {
        final latestPrice = priceHistory.last.price;
        final initialPrice = priceHistory.first.price;

        final changePercentage =
            ((latestPrice - initialPrice) / initialPrice) * 100;

        return Stock(
          symbol: symbol,
          currentPrice: latestPrice,
          changePercentage: changePercentage,
          priceHistory: priceHistory,
        );
      } else {
        return Stock(
          symbol: symbol,
          currentPrice: 0.0,
          changePercentage: 0.0,
          priceHistory: priceHistory,
        );
      }
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}

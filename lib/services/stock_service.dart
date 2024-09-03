import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_model.dart';

class StockService {
  static const String apiKey = 'GSSws3AqUmMAdo33w9svWRXnyUNwbuea';
  final String baseUrl =
      'https://financialmodelingprep.com/api/v3/symbol/NASDAQ';

  Future<List<Stock>> fetchAllStocks() async {
    final response = await http.get(Uri.parse('$baseUrl?apikey=$apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Stock.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}

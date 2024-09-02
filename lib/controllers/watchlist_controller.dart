import 'package:flutter/material.dart';
import '../models/stock_model.dart';

class WatchlistController with ChangeNotifier {
  final List<Stock> _stocks = [];

  List<Stock> get stocks => _stocks;

  Future<void> addStock(Stock stock) async {
    _stocks.add(stock);
    notifyListeners();
  }

  void removeStock(Stock stock) {
    _stocks.remove(stock);
    notifyListeners();
  }
}

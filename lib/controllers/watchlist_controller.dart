import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import '../services/stock_service.dart';

class WatchlistController with ChangeNotifier {
  final StockService _stockService = StockService();
  List<Stock> _stocks = [];

  WatchlistController() {
    _stocks = _stockService.getStaticStockData();
  }

  List<Stock> get stocks => _stocks;

  void addStock(Stock stock) {
    if (_stocks.length < 2) {
      _stocks.add(stock);
      notifyListeners();
    }
  }

  void removeStock(Stock stock) {
    _stocks.remove(stock);
    notifyListeners();
  }
}

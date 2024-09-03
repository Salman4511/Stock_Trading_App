import 'package:flutter/material.dart';
import 'package:stock_trading_app/services/stock_service.dart';
import 'package:stock_trading_app/models/stock_model.dart';

class SearchProvider extends ChangeNotifier {
  List<Stock> _stocks = [];
  List<Stock> _filteredStocks = [];
  bool _isLoading = true;

  List<Stock> get stocks => _filteredStocks;
  bool get isLoading => _isLoading;

  SearchProvider() {
    loadStocks();
  }

  Future<void> loadStocks() async {
    try {
      final service = StockService();
      _stocks = await service.fetchAllStocks();
      _filteredStocks = _stocks;
      print('Stocks loaded: ${_stocks.length}');
    } catch (e) {
      print('Error loading stocks: $e');
      _filteredStocks = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchStocks(String query) {
    if (query.isEmpty) {
      _filteredStocks = _stocks;
    } else {
      _filteredStocks = _stocks
          .where((stock) =>
              stock.symbol.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

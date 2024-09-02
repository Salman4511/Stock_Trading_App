import 'package:flutter/material.dart';
import 'package:stock_trading_app/services/stock_service.dart';
import 'package:stock_trading_app/models/stock_model.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';
  List<Stock> _stocks = [];
  bool _isLoading = false;

  String get query => _query;
  List<Stock> get stocks => _stocks;
  bool get isLoading => _isLoading;

  Future<void> searchStocks(String symbol) async {
    _query = symbol;

    if (symbol.isEmpty) {
      _stocks = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final stock = await StockService().fetchStock(symbol);
      _stocks = [stock];
    } catch (e) {
      _stocks = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

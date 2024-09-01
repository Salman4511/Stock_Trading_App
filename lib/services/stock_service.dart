import '../models/stock_model.dart';
import '../utils/static_data.dart';

class StockService {
  List<Stock> getStaticStockData() {
    return staticStockData.map((data) => Stock.fromJson(data)).toList();
  }
}

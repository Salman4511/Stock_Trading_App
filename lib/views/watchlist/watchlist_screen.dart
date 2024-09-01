import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/utils/static_data.dart';
import '../../controllers/watchlist_controller.dart';
import '../../models/stock_model.dart';
import 'stock_tile.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watchlistController = Provider.of<WatchlistController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Watchlist'),
      ),
      body: ListView.builder(
        itemCount: watchlistController.stocks.length,
        itemBuilder: (context, index) {
          final stock = watchlistController.stocks[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/chart',
                arguments: stock,
              );
            },
            child: StockTile(stock: stock),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Stock? selectedStock = await showDialog<Stock>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Select Stock'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: staticStockData.length,
                    itemBuilder: (context, index) {
                      final stock = Stock.fromJson(staticStockData[index]);
                      return ListTile(
                        title: Text(stock.symbol),
                        onTap: () {
                          Navigator.of(context).pop(stock);
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );

          if (selectedStock != null) {
            watchlistController.addStock(selectedStock);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

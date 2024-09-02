import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/utils/constants.dart';
import '../../controllers/watchlist_controller.dart';
import '../../models/stock_model.dart';
import 'stock_tile.dart';
import 'package:stock_trading_app/utils/static_data.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watchlistController = Provider.of<WatchlistController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stock Watchlist',
          style: TextStyle(color: kwhite, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kBlueGrey,
      ),
      body: watchlistController.stocks.isEmpty
          ? const Center(
              child: Text(
              'Watchlist is Empty',
              style: TextStyle(fontSize: 22),
            ))
          : ListView.builder(
              itemCount: watchlistController.stocks.length,
              itemBuilder: (context, index) {
                final stock = watchlistController.stocks[index];
                return Dismissible(
                  key: Key(stock.symbol),
                  background: Container(
                    color: kRed,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    watchlistController.removeStock(stock);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chart',
                        arguments: stock,
                      );
                    },
                    child: StockTile(stock: stock),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlueGrey,
        onPressed: () async {
          if (watchlistController.stocks.length >= 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('You can only add up to 2 stocks')),
            );
            return;
          }

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

          if (selectedStock != null &&
              !watchlistController.stocks.contains(selectedStock)) {
            watchlistController.addStock(selectedStock);
          }
        },
        child: const Icon(
          Icons.add,
          color: kwhite,
        ),
      ),
    );
  }
}

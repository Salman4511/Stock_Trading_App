// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/utils/search_and_select_dialog.dart';
import 'package:stock_trading_app/views/watchlist/stock_tile.dart';
import '../../controllers/watchlist_controller.dart';
import '../../models/stock_model.dart';
import '../../utils/constants.dart';

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
              ),
            )
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

          final selectedStock = await showDialog<Stock>(
            context: context,
            builder: (context) {
              return SearchAndSelectDialog();
            },
          );

          if (selectedStock != null &&
              !watchlistController.stocks
                  .any((s) => s.symbol == selectedStock.symbol)) {
            try {
              await watchlistController.addStock(selectedStock);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to fetch stock data')),
              );
            }
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

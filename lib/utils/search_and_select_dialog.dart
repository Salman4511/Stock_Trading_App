import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/controllers/search_controller.dart';

class SearchAndSelectDialog extends StatelessWidget {
  const SearchAndSelectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Stocks',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) => searchProvider.searchStocks(query),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: searchProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : searchProvider.stocks.isEmpty
                      ? const Center(child: Text('No stocks found'))
                      : ListView.builder(
                          itemCount: searchProvider.stocks.length,
                          itemBuilder: (context, index) {
                            final stock = searchProvider.stocks[index];
                            return ListTile(
                              title: Text(stock.symbol),
                              subtitle: Text('\$${stock.currentPrice}'),
                              onTap: () {
                                Navigator.of(context).pop(stock);
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

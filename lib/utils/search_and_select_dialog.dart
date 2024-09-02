import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/controllers/search_controller.dart';

class SearchAndSelectDialog extends StatelessWidget {
  const SearchAndSelectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return AlertDialog(
      title: const Text('Search Stocks'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter stock symbol',
            ),
            onChanged: (value) {
              searchProvider.searchStocks(value);
            },
          ),
          const SizedBox(height: 20.0),
          if (searchProvider.isLoading)
            const CircularProgressIndicator()
          else if (searchProvider.stocks.isEmpty)
            const Text('Stock not found')
          else
            SizedBox(
              width: double.maxFinite,
              height: 150,
              child: ListView.builder(
                itemCount: searchProvider.stocks.length,
                itemBuilder: (context, index) {
                  final stock = searchProvider.stocks[index];
                  return ListTile(
                    title: Text(stock.symbol),
                    onTap: () {
                      Navigator.of(context).pop(stock);
                    },
                  );
                },
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

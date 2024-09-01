import 'package:flutter/material.dart';
import '../../models/stock_model.dart';

class StockTile extends StatelessWidget {
  final Stock stock;

  const StockTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stock.symbol),
      subtitle: Text('Price: \$${stock.currentPrice.toStringAsFixed(2)}'),
      trailing: Text(
        '${stock.changePercentage.toStringAsFixed(2)}%',
        style: TextStyle(
          color: stock.changePercentage >= 0 ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

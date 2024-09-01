import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/stock_model.dart';

class StockChartScreen extends StatelessWidget {
  final Stock stock;

  const StockChartScreen({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${stock.symbol} Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: stock.priceHistory
                    .map((e) => FlSpot(e.time.toDouble(), e.price))
                    .toList(),
                isCurved: true,
                barWidth: 2,
                dotData: const FlDotData(show: false),
              ),
            ],
            titlesData: const FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 22),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
              ),
            ),
            gridData: const FlGridData(show: true),
            borderData: FlBorderData(show: true),
          ),
        ),
      ),
    );
  }
}

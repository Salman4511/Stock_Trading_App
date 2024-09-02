import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/stock_model.dart';
import '../../utils/constants.dart';

class StockChartScreen extends StatelessWidget {
  final Stock stock;

  const StockChartScreen({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${stock.symbol} Chart',
          style: const TextStyle(color: kwhite),
        ),
        backgroundColor: kBlueGrey,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: LineChart(
          LineChartData(
            backgroundColor: kBlueAccent.withOpacity(0.1),
            lineBarsData: [
              LineChartBarData(
                spots: stock.priceHistory
                    .map((e) => FlSpot(e.time.toDouble(), e.price))
                    .toList(),
                isCurved: true,
                color: kGreenAccent,
                barWidth: 3,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: kGreenAccent.withOpacity(0.3),
                ),
                curveSmoothness: 0.2,
              ),
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: (stock.priceHistory.length / 10).toDouble(),
                  getTitlesWidget: (value, meta) {
                    return Text(
                      'T${value.toInt()}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kBlueAccent,
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: (stock.currentPrice / 5).toDouble(),
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '\$${value.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kBlueAccent,
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              verticalInterval: 1,
              horizontalInterval: (stock.currentPrice / 5).toDouble(),
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: kBlueAccent.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: kBlueAccent.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: kBlueAccent.withOpacity(0.5),
                width: 2,
              ),
            ),
            minX: 1,
            maxX: stock.priceHistory.length.toDouble(),
            minY: stock.priceHistory
                .map((e) => e.price)
                .reduce((value, element) => value < element ? value : element),
            maxY: stock.priceHistory
                .map((e) => e.price)
                .reduce((value, element) => value > element ? value : element),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((touchedSpot) {
                    return LineTooltipItem(
                      '\$${touchedSpot.y.toStringAsFixed(2)}\nT${touchedSpot.x.toInt()}',
                      const TextStyle(
                        color: kwhite,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
              touchCallback: (event, response) {},
              handleBuiltInTouches: true,
            ),
          ),
        ),
      ),
    );
  }
}

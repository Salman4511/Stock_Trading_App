import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/watchlist/watchlist_screen.dart';
import 'views/chart/stock_chart_screen.dart';
import 'controllers/watchlist_controller.dart';
import 'models/stock_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WatchlistController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stock Trading App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WatchlistScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/chart') {
            final Stock? stock = settings.arguments as Stock?;
            if (stock != null) {
              return MaterialPageRoute(
                builder: (context) => StockChartScreen(stock: stock),
              );
            }
          }
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('404')),
              body: const Center(child: Text('Page not found')),
            ),
          );
        },
      ),
    );
  }
}

import 'package:notifycart/viewmodel/cart.dart';
import 'package:notifycart/viewmodel/stock.dart';
import 'package:provider/provider.dart';
import 'package:notifycart/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ChangeNotifier Cart Example',
      theme: ThemeData.light(),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => StockViewModel()..getPizzas(),
          ),
          ChangeNotifierProvider(create: (context) => CartViewModel()),
        ],
        child: const HomePage(),
      ),
    );
  }
}

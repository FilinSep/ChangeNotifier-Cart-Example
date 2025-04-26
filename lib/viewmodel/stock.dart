import 'package:flutter/material.dart';

class StockViewModel extends ChangeNotifier {
  Map<String, double>? data;

  void getPizzas() async {
    // Emitate long work...
    await Future.delayed(Duration(seconds: 2));

    data = {
      // name : price
      'Peperoni': 10.00,
      'Margherita': 10.00,
      'Neapolitan': 15.99,
      'Greek': 12.99,
      'Chicago': 12.99,
      'Calzone': 12.99,
      'Detroit': 12.99,
    };
    notifyListeners();
  }
}

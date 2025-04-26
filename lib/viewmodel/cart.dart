import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  List<String> content = [];

  void add(String product) {
    content.add(product);
    notifyListeners();
  }

  void remove(String product) {
    content.remove(product);
    notifyListeners();
  }

  bool get isEmpty => content.isEmpty;
  int get length => content.length;

  bool contains(String product) => content.contains(product);
}

import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';

class OrderItem {
  final String id;
  final List<CartItem> products;
  final double amount;
  final DateTime dateTime;
  OrderItem({
    required this.amount,
    required this.dateTime,
    required this.id,
    required this.products,
  });
}

class Order with ChangeNotifier {
  // ignore: prefer_final_fields
  List<OrderItem> _orders = [];

  List<OrderItem> get order {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double amount) {
    _orders.insert(
        0,
        OrderItem(
          amount: amount,
          dateTime: DateTime.now(),
          id: DateTime.now().toString(),
          products: cartProducts,
        ));
    notifyListeners();
  }
}

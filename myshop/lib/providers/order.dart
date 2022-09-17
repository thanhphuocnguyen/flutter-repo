import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myshop/models/http_exception.dart';
import 'package:myshop/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'package:myshop/providers/products.dart';

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
  final String? authToken;
  final String? userId;

  Order(
    this.authToken,
    this._orders,
    this.userId,
  );

  List<OrderItem> get order {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final orderUri = Uri.https(
        Products.baseUrl, '/orders/$userId.json', {'auth': '$authToken'});
    try {
      final response = await http.get(orderUri);
      if (response.statusCode == 200) {
        final parsedResponse =
            json.decode(response.body) as Map<String, dynamic>?;
        if (parsedResponse != null) {
          List<OrderItem> orderFetched = [];
          parsedResponse.forEach((key, value) {
            orderFetched.add(OrderItem(
                amount: value['amount'],
                dateTime: DateTime.parse(value['datetime']),
                id: key,
                products: (value['products'] as List<dynamic>)
                    .map(
                      (e) => CartItem(
                          id: e['id'],
                          price: e['price'],
                          quantity: e['quantity'],
                          title: e['title']),
                    )
                    .toList()));
          });
          _orders = orderFetched;
          notifyListeners();
        }
      } else {
        throw CustomException(json.decode(response.body)['message']);
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double amount) async {
    final orderUri = Uri.https(
        Products.baseUrl, '/orders/$userId.json', {'auth': '$authToken'});
    try {
      final response = await http.post(orderUri,
          body: json.encode({
            'amount': amount,
            'datetime': DateTime.now().toIso8601String(),
            'products': cartProducts
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'price': e.price,
                      'quantity': e.quantity,
                    })
                .toList(),
          }));
      if (response.statusCode == 200) {
        _orders.insert(
            0,
            OrderItem(
              amount: amount,
              dateTime: DateTime.now(),
              id: json.decode(response.body)['name'] as String,
              products: cartProducts,
            ));
        notifyListeners();
      } else {
        throw CustomException(json.decode(response.body)['message']);
      }
    } catch (err) {
      rethrow;
    }
  }
}

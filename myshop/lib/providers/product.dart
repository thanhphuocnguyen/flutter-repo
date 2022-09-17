import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myshop/models/http_exception.dart';
import 'package:myshop/providers/products.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  final String? authToken;
  final String? creatorId;
  Product({
    required this.id,
    required this.description,
    required this.imageUrl,
    this.isFavourite = false,
    required this.price,
    required this.title,
    required this.authToken,
    required this.creatorId,
  });

  Future<void> toggleFavourite(String? token, String? userId) async {
    try {
      final toggleFavUri = Uri.https(Products.baseUrl,
          '/isFavourite/$userId/$id.json', {'auth': '$token'});
      final response =
          await http.put(toggleFavUri, body: json.encode(!isFavourite));
      if (response.statusCode == 200) {
        isFavourite = !isFavourite;
        notifyListeners();
      } else {
        throw CustomException(json.decode(response.body)['message']);
      }
    } catch (err) {
      rethrow;
    }
  }
}

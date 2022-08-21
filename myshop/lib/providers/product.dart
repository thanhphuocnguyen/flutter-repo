import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product({
    required this.id,
    required this.description,
    required this.imageUrl,
    this.isFavourite = false,
    required this.price,
    required this.title,
  });

  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}

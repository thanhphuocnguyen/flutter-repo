import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myshop/models/http_exception.dart';
import 'package:myshop/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  static const String baseUrl =
      'flutter-apis-c651f-default-rtdb.asia-southeast1.firebasedatabase.app';

  final String? authToken;
  final String? userId;

  Products(this.authToken, this._items, this.userId);
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchandSetProducts([bool filterByUser = false]) async {
    final filterQuery = filterByUser
        ? {'orderBy': json.encode("creatorId"), 'equalTo': json.encode(userId)}
        : {};
    final productUri = Uri.https(baseUrl, '/products.json', {
      'auth': '$authToken',
      ...filterQuery,
    });
    try {
      final response = await http.get(productUri);
      if (response.statusCode == 200) {
        final productParsed =
            json.decode(response.body) as Map<String, dynamic>?;
        final favouriteUri = Uri.https(
            baseUrl, '/isFavourite/$userId.json', {'auth': '$authToken'});
        final favResponse = await http.get(favouriteUri);
        final favData = jsonDecode(favResponse.body);
        List<Product> listProductParsed = [];
        if (productParsed != null) {
          productParsed.forEach((key, value) {
            listProductParsed.add(Product(
              id: key,
              title: value['title'],
              description: value['description'],
              imageUrl: value['imageUrl'],
              isFavourite: favData == null ? false : favData[key] ?? false,
              price: value['price'],
              authToken: value['authToken'],
              creatorId: value['creatorId'],
            ));
          });
          _items = listProductParsed;
        }
      } else {
        throw CustomException(jsonDecode(response.body));
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final productUri =
        Uri.https(baseUrl, '/products.json', {'auth': '$authToken'});
    try {
      final response = await http.post(productUri,
          body: json.encode({
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'title': product.title,
            'isFavourite': product.isFavourite,
            'creatorId': userId,
          }));
      if (response.statusCode == 200) {
        final newProduct = Product(
            description: product.description,
            id: json.decode(response.body)['name'] as String,
            imageUrl: product.imageUrl,
            price: product.price,
            title: product.title,
            authToken: product.authToken,
            creatorId: product.creatorId);
        _items.insert(0, newProduct);
        notifyListeners();
      } else {
        throw CustomException(json.decode(response.body)['message']);
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product editProduct) async {
    final updateproductUri =
        Uri.https(baseUrl, '/products/$id.json', {'auth': '$authToken'});
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      try {
        final response = await http.patch(updateproductUri,
            body: json.encode({
              'title': editProduct.title,
              'price': editProduct.price,
              'description': editProduct.description,
              'imageUrl': editProduct.imageUrl,
              'isFavourite': editProduct.isFavourite,
            }));
        if (response.statusCode == 200) {
          _items[prodIndex] = editProduct;
          notifyListeners();
        } else {
          print(json.decode(response.body));
          throw CustomException(json.decode(response.body)['message']);
        }
      } catch (err) {
        print(err);
        rethrow;
      }
    } else {
      return;
    }
  }

  Future<void> removeProductWhere(String prodId) async {
    final updateproductUri = Uri.https(baseUrl, '/products/$prodId.json');
    try {
      final response = await http.delete(updateproductUri);
      if (response.statusCode == 200) {
        _items.removeWhere((element) => element.id == prodId);
        notifyListeners();
      } else {
        print(json.decode(response.body));
        throw CustomException(json.decode(response.body)['message']);
      }
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }
}

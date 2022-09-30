import 'dart:io';

import 'package:flutter/material.dart';
import 'package:using_native_device/helpers/db_helper.dart';
import 'package:using_native_device/models/place.dart';

class GreatPlace with ChangeNotifier {
  List<Place> _places = [];
  List<Place> get places {
    return _places;
  }

  void addPlace(String placeTitle, File placeImage) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      image: placeImage,
      location: null,
      title: placeTitle,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final listPlaces = await DBHelper.getData('user_places');
    _places = listPlaces
        .map(
          (e) => Place(
            id: e['id'] as String,
            image: File(e['image'] as String),
            location: null,
            title: e['title'] as String,
          ),
        )
        .toList();
    notifyListeners();
  }
}

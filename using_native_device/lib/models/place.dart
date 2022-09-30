import 'dart:io';

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;
  Place({
    required this.id,
    required this.image,
    required this.location,
    required this.title,
  });
}

class PlaceLocation {
  final double longitude;
  final double latitude;
  final String? address;
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

// ignore_for_file: constant_identifier_names

const GOOGLE_API_KEY = 'AIzaSyBNLrJhOMz6idD05pzfn5lhA-TAw-mAZCU';
const GOOGLE_API_SIGNATURE = '';
const MAP_BOX_API_KEY = '';

class LocationHelper {
  static String generateGoogleLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return '''https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY&signature=BASE64_SIGNATURE''';
  }

  static String generateMapboxLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return '''https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l
    ($longitude,$latitude)/$longitude,$latitude,
    14.25,0,0/600x300?access_token=$MAP_BOX_API_KEY''';
  }
}

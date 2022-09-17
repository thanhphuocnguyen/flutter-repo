import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myshop/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    String requestUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAjB08PN-4iERQWNK8KYFFhAppIe3xPTLg';
    final uriParsed = Uri.parse(requestUrl);
    try {
      final response = await http.post(uriParsed,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final resData = jsonDecode(response.body);
      if (resData['error'] != null) {
        throw CustomException(resData['error']['message']);
      }
      _token = resData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(resData['expiresIn'])));
      _userId = resData['localId'];
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      await prefs.setString('userData', userData);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractUserData =
        jsonDecode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractUserData['expiryDate']);
    if (expiryDate.isAfter(DateTime.now())) {
      return false;
    }
    _expiryDate = expiryDate;
    _userId = extractUserData['userId'];
    _token = extractUserData['token'];
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _expiryDate = null;
    _token = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    final secondes = _expiryDate == null
        ? 0
        : _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: secondes), logout);
  }
}

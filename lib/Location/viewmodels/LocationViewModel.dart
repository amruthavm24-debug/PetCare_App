import 'package:flutter/material.dart';
class LocationViewModel extends ChangeNotifier {
  String _city = 'Hyderabad';
  String get city => _city;

  void setCity(String c) {
    _city = c;
    notifyListeners();
  }
}
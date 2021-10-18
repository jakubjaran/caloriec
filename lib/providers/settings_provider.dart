import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  String _username = 'Imię';
  String get username => _username;

  int _maxCalories = 2500;
  int get maxCalories => _maxCalories;

  void updateSettings(String username, int maxCalories) {
    _username = username;
    _maxCalories = maxCalories;
    notifyListeners();
  }
}

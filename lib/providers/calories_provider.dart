import 'package:flutter/material.dart';

class CaloriesProvider with ChangeNotifier {
  int _caloriesValue = 0;
  int get caloriesValue => _caloriesValue;

  List<int> _quickValues = [10, 25, 50, 75, 100, 150, 200];
  List<int> get quickValues => _quickValues;

  void updateCalories(int value) {
    _caloriesValue += value;
    if (_caloriesValue < 0) {
      _caloriesValue = 0;
    }
    notifyListeners();
  }

  void toggleQuickValues() {
    _quickValues = _quickValues.map((val) => val * -1).toList();
    notifyListeners();
  }
}

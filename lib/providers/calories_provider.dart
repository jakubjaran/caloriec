import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CaloriesProvider with ChangeNotifier {
  int _caloriesValue = 0;
  int get caloriesValue => _caloriesValue;

  List<int> _quickValues = [10, 25, 50, 75, 100, 150, 200];
  List<int> get quickValues => _quickValues;

  int _maxCalories = 0;
  int get maxCalories => _maxCalories;

  void updateMaxCalories(int value) async {
    _maxCalories = value;
    var box = await Hive.openBox('db');
    await box.put('maxCalories', _maxCalories);
    await box.close();
    notifyListeners();
  }

  void updateCalories(int value) async {
    _caloriesValue += value;
    if (_caloriesValue < 0) {
      _caloriesValue = 0;
    }
    var box = await Hive.openBox('db');
    await box.put('caloriesValue', _caloriesValue);
    await box.put('date', DateTime.now());
    await box.close();
    notifyListeners();
  }

  void toggleQuickValues() {
    _quickValues = _quickValues.map((val) => val * -1).toList();
    notifyListeners();
  }

  void fetchDB() async {
    var box = await Hive.openBox('db');
    final DateTime date = box.get('date', defaultValue: DateTime.now());
    if (date.day != DateTime.now().day) {
      _caloriesValue = 0;
      await box.put('caloriesValue', _caloriesValue);
    } else {
      _caloriesValue = await box.get('caloriesValue', defaultValue: 0);
    }
    _maxCalories = await box.get('maxCalories', defaultValue: 2500);
    await box.close();
    notifyListeners();
  }
}

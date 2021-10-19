import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CaloriesProvider with ChangeNotifier {
  int _caloriesValue = 0;
  int get caloriesValue => _caloriesValue;

  final List<int> _quickValues = [5, 10, 25, 50, 75, 100, 150, 200];
  List<int> get quickValues => _quickValues;

  int _maxCalories = 0;
  int get maxCalories => _maxCalories;

  List<int> _addedValues = [];
  List<int> get addedValues => _addedValues;

  List<int> _redoValues = [];
  List<int> get redoValues => _redoValues;

  void updateMaxCalories(int value) async {
    _maxCalories = value;
    var box = await Hive.openBox('db');
    await box.put('maxCalories', _maxCalories);
    await box.close();
    notifyListeners();
  }

  void updateCalories(int value, {bool? isUndo}) async {
    if (value > 0) {
      _addedValues.insert(0, value);
    }
    if (isUndo == null) {
      _redoValues = [];
    }
    // print('Added $_addedValues');
    // print('Redo $_redoValues');
    _caloriesValue = _addedValues.fold(0, (p, c) => p + c);
    var box = await Hive.openBox('db');
    await box.put('addedValues', _addedValues);
    await box.put('date', DateTime.now());
    await box.close();
    notifyListeners();
  }

  void undoCaloriesUpdate() {
    if (_addedValues.isNotEmpty) {
      final value = _addedValues[0] * -1;
      _redoValues.insert(0, _addedValues[0]);
      _addedValues.removeAt(0);

      updateCalories(value, isUndo: true);
      notifyListeners();
    }
  }

  void redoCaloriesUpdate() {
    if (_redoValues.isNotEmpty) {
      updateCalories(_redoValues[0], isUndo: false);
      _redoValues.removeAt(0);
      notifyListeners();
    }
  }

  void fetchDB() async {
    var box = await Hive.openBox('db');
    final DateTime date = box.get('date', defaultValue: DateTime.now());
    if (date.day != DateTime.now().day) {
      _addedValues = [];
      await box.put('addedValues', _addedValues);
    } else {
      _addedValues = await box.get('addedValues', defaultValue: <int>[]);
      _caloriesValue = _addedValues.fold(0, (p, c) => p + c);
    }
    _maxCalories = await box.get('maxCalories', defaultValue: 2500);
    await box.close();
    notifyListeners();
  }
}

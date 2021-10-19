import 'package:caloriec/providers/calories_provider.dart';
import 'package:caloriec/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryControls extends StatelessWidget {
  const HistoryControls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CaloriesProvider>(builder: (_, data, ch) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: data.addedValues.isNotEmpty
                ? () {
                    data.undoCaloriesUpdate();
                  }
                : null,
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(HistoryScreen.path);
            },
            icon: const Icon(Icons.history),
          ),
          IconButton(
            onPressed: data.redoValues.isNotEmpty
                ? () {
                    data.redoCaloriesUpdate();
                  }
                : null,
            icon: const Icon(Icons.redo),
          ),
        ],
      );
    });
  }
}

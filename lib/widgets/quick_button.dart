import 'package:caloriec/providers/calories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuickButton extends StatelessWidget {
  final int value;

  const QuickButton(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final cp = context.read<CaloriesProvider>();
        value == 0 ? cp.toggleQuickValues() : cp.updateCalories(value);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.surface,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Text(
        value == 0 ? '+ / -' : '$value',
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[300]),
      ),
    );
  }
}

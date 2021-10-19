import 'package:caloriec/providers/calories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryListTile extends StatelessWidget {
  final int value;
  final int index;

  const HistoryListTile(this.value, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      title: Text(
        '$value kcal',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          context.read<CaloriesProvider>().removeFromHistory(index);
        },
      ),
    );
  }
}

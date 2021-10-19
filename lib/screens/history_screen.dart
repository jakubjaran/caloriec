import 'package:caloriec/providers/calories_provider.dart';
import 'package:caloriec/widgets/history_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  static const String path = '/history';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Historia'),
      ),
      body: Consumer<CaloriesProvider>(
        builder: (_, data, ch) {
          return data.addedValues.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView.separated(
                    itemCount: data.addedValues.length,
                    itemBuilder: (_, index) => HistoryListTile(
                      data.addedValues[index],
                      index,
                    ),
                    separatorBuilder: (_, index) => Divider(
                      color: Colors.grey[900],
                      thickness: 2,
                    ),
                  ),
                )
              : const Center(
                  child: Text('Historia jest pusta'),
                );
        },
      ),
    );
  }
}

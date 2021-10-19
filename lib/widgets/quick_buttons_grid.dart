import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calories_provider.dart';
import 'quick_button.dart';

class QuickButtonsGrid extends StatelessWidget {
  const QuickButtonsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<CaloriesProvider>(builder: (_, data, ch) {
        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          children: [
            for (int val in data.quickValues) QuickButton(val),
          ],
        );
      }),
    );
  }
}

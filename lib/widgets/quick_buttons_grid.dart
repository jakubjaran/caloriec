import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calories_provider.dart';
import 'quick_button.dart';

class QuickButtonsGrid extends StatelessWidget {
  final int newValue;
  final Function addValue;

  const QuickButtonsGrid(
    this.newValue,
    this.addValue, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            addValue(newValue * -1);
          },
          child: Text(
            newValue > 0 ? '$newValue' : '',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<CaloriesProvider>(builder: (_, data, ch) {
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              children: [
                for (int val in data.quickValues) QuickButton(val, addValue),
              ],
            );
          }),
        ),
      ],
    );
  }
}

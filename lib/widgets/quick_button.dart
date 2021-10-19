import 'package:flutter/material.dart';

class QuickButton extends StatelessWidget {
  final int value;
  final Function addValue;

  const QuickButton(this.value, this.addValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => addValue(value),
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

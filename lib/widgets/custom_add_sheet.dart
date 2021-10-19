import 'package:caloriec/widgets/search_dialog.dart';

import '../providers/calories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAddSheet extends StatefulWidget {
  const CustomAddSheet({Key? key}) : super(key: key);

  @override
  State<CustomAddSheet> createState() => _CustomAddSheetState();
}

class _CustomAddSheetState extends State<CustomAddSheet> {
  final _calPer100Controller = TextEditingController();

  final _weightController = TextEditingController();

  final _calculatedCalController = TextEditingController();

  void _calculate() {
    final calPer100 = int.tryParse(_calPer100Controller.text);
    final weight = int.tryParse(_weightController.text);
    if (calPer100 != null && weight != null) {
      _calculatedCalController.text = (calPer100 * weight ~/ 100).toString();
    }
  }

  void _addCalories() {
    if (_calculatedCalController.text != '') {
      context
          .read<CaloriesProvider>()
          .updateCalories(int.parse(_calculatedCalController.text));
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    _weightController.addListener(() {
      _calculate();
    });
    _calPer100Controller.addListener(() {
      _calculate();
    });
    super.initState();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _calPer100Controller.dispose();
    _calculatedCalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        left: 40,
        top: 20,
        right: 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              label: Text('Ile kcal na 100g'),
            ),
            keyboardType: TextInputType.number,
            controller: _calPer100Controller,
            textInputAction: TextInputAction.next,
          ),
          TextField(
            decoration: const InputDecoration(
              label: Text('Ile gram'),
            ),
            keyboardType: TextInputType.number,
            controller: _weightController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              _addCalories();
            },
          ),
          TextField(
            decoration: const InputDecoration(
              label: Text('Ile kalorii'),
            ),
            enabled: false,
            keyboardType: TextInputType.number,
            controller: _calculatedCalController,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const SearchDialog(),
                  );
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: const Text(
                  'Sprawdź',
                ),
              ),
              ElevatedButton.icon(
                onPressed: _addCalories,
                icon: const Icon(Icons.add),
                label: const Text('Dodaj'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

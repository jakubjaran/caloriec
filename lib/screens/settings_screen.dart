import '../providers/calories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String route = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _caloriesController = TextEditingController();

  @override
  void initState() {
    _caloriesController.text =
        context.read<CaloriesProvider>().maxCalories.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Ustawienia'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 40),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text('Ilość kalorii'),
              ),
              keyboardType: TextInputType.number,
              controller: _caloriesController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                context.read<CaloriesProvider>().updateMaxCalories(
                      int.parse(_caloriesController.text),
                    );
              },
              icon: const Icon(Icons.save),
              label: const Text('Zapisz'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

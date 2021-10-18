import 'package:caloriec/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String route = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _usernameController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  void initState() {
    final settings = context.read<SettingsProvider>();
    _usernameController.text = settings.username;
    _caloriesController.text = settings.maxCalories.toString();
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                label: Text('Imię'),
              ),
              controller: _usernameController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              textAlign: TextAlign.center,
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
                context.read<SettingsProvider>().updateSettings(
                      _usernameController.text,
                      int.parse(_caloriesController.text),
                    );
              },
              icon: const Icon(Icons.save),
              label: const Text('Zapisz'),
            )
          ],
        ),
      ),
    );
  }
}

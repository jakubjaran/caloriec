import 'package:caloriec/providers/calories_provider.dart';
import 'package:caloriec/widgets/history_controls.dart';

import 'settings_screen.dart';
import '../widgets/counter.dart';
import '../widgets/custom_add_sheet.dart';
import '../widgets/quick_buttons_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<CaloriesProvider>().fetchDB();
    super.initState();
  }

  void _showSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return const CustomAddSheet();
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
    );
  }

  int _newValue = 0;

  void addValue(int value) {
    setState(() {
      _newValue += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.route);
            },
            icon: Icon(
              Icons.settings,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 90),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Counter(),
              const Spacer(),
              const HistoryControls(),
              const SizedBox(height: 20),
              QuickButtonsGrid(_newValue, addValue),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(200),
            topRight: Radius.circular(200),
          ),
        ),
        onPressed: _newValue == 0
            ? _showSheet
            : () {
                context.read<CaloriesProvider>().updateCalories(_newValue);
                setState(() {
                  _newValue = 0;
                });
              },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:caloriec/providers/calories_provider.dart';
import 'package:caloriec/providers/settings_provider.dart';
import 'package:caloriec/screens/settings_screen.dart';
import 'package:caloriec/widgets/quick_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Consumer<SettingsProvider>(builder: (_, settings, ch) {
            final _maxCalories = settings.maxCalories;
            final _username = settings.username;
            return Column(
              children: [
                Text(
                  'Witaj, $_username',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<CaloriesProvider>(
                  builder: (_, data, ch) {
                    final double counterPercent =
                        data.caloriesValue / _maxCalories;
                    return CircularPercentIndicator(
                      animation: true,
                      animationDuration: 400,
                      animateFromLastPercent: true,
                      radius: 250,
                      lineWidth: 15,
                      percent: counterPercent >= 0 && counterPercent <= 1
                          ? counterPercent
                          : 1,
                      progressColor: data.caloriesValue <= _maxCalories
                          ? Colors.green
                          : Colors.red,
                      backgroundColor: Colors.grey[900]!,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_maxCalories - data.caloriesValue}',
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'kcal',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer<CaloriesProvider>(builder: (_, data, ch) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      children: [
                        for (int val in data.quickValues) QuickButton(val),
                        const QuickButton(0),
                      ],
                    );
                  }),
                )
              ],
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(200),
            topRight: Radius.circular(200),
          ),
        ),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

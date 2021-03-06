import 'package:caloriec/screens/history_screen.dart';
import 'package:caloriec/screens/search_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'providers/calories_provider.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CaloriesProvider(),
      child: MaterialApp(
        title: 'Caloriec',
        theme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.green,
            secondary: Colors.green,
            background: Colors.black,
            surface: Colors.grey[900]!,
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onBackground: Colors.white,
            onSurface: Colors.white,
            onError: Colors.white,
            primaryVariant: Colors.greenAccent,
            secondaryVariant: Colors.greenAccent,
          ),
        ),
        routes: {
          HomeScreen.route: (_) => const HomeScreen(),
          SettingsScreen.route: (_) => const SettingsScreen(),
          SearchScreen.route: (_) => const SearchScreen(),
          HistoryScreen.path: (_) => const HistoryScreen(),
        },
      ),
    );
  }
}

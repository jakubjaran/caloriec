import 'package:caloriec/providers/calories_provider.dart';
import 'package:caloriec/providers/settings_provider.dart';
import 'package:caloriec/screens/home_screen.dart';
import 'package:caloriec/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider<CaloriesProvider>(
          create: (_) => CaloriesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'caloriec',
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
        },
      ),
    );
  }
}

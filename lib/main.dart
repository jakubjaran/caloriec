import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalorieC',
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isAdding = true;

  int _counterValue = 0;

  final int _maxCalories = 2000;

  void toggleAdding(_) {
    setState(() {
      _isAdding = !_isAdding;
    });
  }

  void addCalories(int val) {
    setState(() {
      _isAdding ? _counterValue += val : _counterValue -= val;
      _counterValue < 0 ? _counterValue = 0 : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double counterPercent = _counterValue / _maxCalories;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Center(
          child: Column(
            children: [
              Text(
                'Witaj, Kuba',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CircularPercentIndicator(
                animation: true,
                animationDuration: 400,
                animateFromLastPercent: true,
                radius: 250,
                lineWidth: 15,
                percent: counterPercent >= 0 && counterPercent <= 1
                    ? counterPercent
                    : 1,
                progressColor:
                    _counterValue <= _maxCalories ? Colors.green : Colors.red,
                backgroundColor: Colors.grey[900]!,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_maxCalories - _counterValue}',
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
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 300,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  children: [
                    QuickButton(10, _isAdding, addCalories),
                    QuickButton(25, _isAdding, addCalories),
                    QuickButton(50, _isAdding, addCalories),
                    QuickButton(75, _isAdding, addCalories),
                    QuickButton(100, _isAdding, addCalories),
                    QuickButton(150, _isAdding, addCalories),
                    QuickButton(200, _isAdding, addCalories),
                    QuickButton(
                      0,
                      _isAdding,
                      toggleAdding,
                    ),
                  ],
                ),
              )
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class QuickButton extends StatelessWidget {
  final int value;
  final bool isAdding;
  final Function callback;

  const QuickButton(this.value, this.isAdding, this.callback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => callback(value),
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
        value == 0
            ? '+ / -'
            : isAdding
                ? '$value'
                : '-$value',
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[300]),
      ),
    );
  }
}

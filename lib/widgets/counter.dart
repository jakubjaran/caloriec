import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../providers/calories_provider.dart';

class Counter extends StatefulWidget {
  const Counter({
    Key? key,
  }) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  bool _animate = false;

  void _animateCounter() {
    setState(() {
      _animate = true;
    });
    Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _animate = false;
      });
    });
  }

  late int _previousValue;

  @override
  void initState() {
    _previousValue = context.read<CaloriesProvider>().caloriesValue;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final currentValue = context.watch<CaloriesProvider>().caloriesValue;
    if (currentValue != _previousValue) {
      _animateCounter();
      _previousValue = currentValue;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CaloriesProvider>(
      builder: (_, data, ch) {
        if (data.maxCalories == 0) {
          return const SizedBox.shrink();
        }
        final double counterPercent = data.caloriesValue / data.maxCalories;
        return CircularPercentIndicator(
          animation: true,
          animationDuration: 600,
          animateFromLastPercent: true,
          curve: Curves.linear,
          radius: 250,
          lineWidth: 15,
          percent:
              counterPercent >= 0 && counterPercent <= 1 ? counterPercent : 1,
          progressColor: data.caloriesValue <= data.maxCalories
              ? Colors.green
              : Colors.red,
          backgroundColor: Colors.grey[900]!,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 100),
                style: _animate
                    ? TextStyle(
                        fontSize: 45,
                        color: data.caloriesValue <= data.maxCalories
                            ? Colors.green
                            : Colors.red,
                      )
                    : const TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                curve: Curves.linear,
                overflow: TextOverflow.fade,
                softWrap: true,
                child: Text(
                  '${data.maxCalories - data.caloriesValue}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '/ ${data.maxCalories} kcal',
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
    );
  }
}

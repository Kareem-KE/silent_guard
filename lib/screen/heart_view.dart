import 'dart:async';
import 'package:flutter/material.dart';
import 'package:silent_guard/widget/animated_title.dart';
import 'package:silent_guard/widget/custom_line_chart.dart';

class HeartView extends StatefulWidget {
  const HeartView({super.key});

  @override
  State<HeartView> createState() => _HeartViewState();
}

class _HeartViewState extends State<HeartView>
    with SingleTickerProviderStateMixin {
  final List<double> heartRates = [];
  final List<double> spo2Levels = [];
  final List<String> timeLabels = [];

  late AnimationController _controller;
  late Animation<double> _heartAnimation;
  late Animation<double> _oxygenAnimation;
  Timer? _mockDataTimer;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startMockData();
  }

  @override
  void dispose() {
    _controller.dispose();
    _mockDataTimer?.cancel();
    super.dispose();
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _heartAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _oxygenAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _startMockData() {
    _mockDataTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final timeLabel = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

      setState(() {
        heartRates.add(60 + (10 * (1 - (DateTime.now().second % 2))));
        spo2Levels.add(95 + (DateTime.now().second % 3));
        timeLabels.add(timeLabel);

        if (heartRates.length > 20) heartRates.removeAt(0);
        if (spo2Levels.length > 20) spo2Levels.removeAt(0);
        if (timeLabels.length > 20) timeLabels.removeAt(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 200),
      child: Column(
        children: [
          AnimatedTitle(text: '🫀 Heart Rate 🫀', animation: _heartAnimation),
          CustomLineChart(
            data: heartRates,
            lineColor: Theme.of(context).colorScheme.error,
            timeLabels: timeLabels,
          ),
          const SizedBox(height: 16),
          AnimatedTitle(text: '🌬️ Oxygen 🌬️', animation: _oxygenAnimation),
          CustomLineChart(
            data: spo2Levels,
            lineColor: Colors.blue,
            timeLabels: timeLabels,
          ),
          const SizedBox(height: 30),
          Text(
            'Your heart rate and oxygen is updated live while using the sensor',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

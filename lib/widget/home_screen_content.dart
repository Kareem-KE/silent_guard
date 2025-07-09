import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:silent_guard/widget/animated_logo_wave.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bpmRef = FirebaseDatabase.instance.ref("sensorData/bpm");
    final spo2Ref = FirebaseDatabase.instance.ref("sensorData/spo2");

    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const AnimatedLogoWave(),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _buildDataStream(
                        context,
                        stream: spo2Ref.onValue,
                        title: 'Oxygen\nPercentage',
                        suffix: '%',
                        fallback: 98,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: _buildDataStream(
                        context,
                        stream: bpmRef.onValue,
                        title: 'Heartbeats',
                        suffix: 'bpm',
                        fallback: 75,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataStream(
    BuildContext context, {
    required Stream<DatabaseEvent> stream,
    required String title,
    required String suffix,
    required dynamic fallback,
  }) {
    return StreamBuilder<DatabaseEvent>(
      stream: stream,
      builder: (context, snapshot) {
        final value = snapshot.data?.snapshot.value ?? fallback;
        return _buildDataCard(
          context: context,
          title: title,
          value: '$value $suffix',
        );
      },
    );
  }

  Widget _buildDataCard({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: const Color.fromARGB(255, 1, 131, 96).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFF555555), width: 4.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                value,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedLogoWave extends StatefulWidget {
  const AnimatedLogoWave({super.key});

  @override
  State<AnimatedLogoWave> createState() => _AnimatedLogoWaveState();
}

class _AnimatedLogoWaveState extends State<AnimatedLogoWave>
    with TickerProviderStateMixin {
  final String _text = 'BIO AI-VEST';
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];

  Timer? _periodicTimer;

  @override
  void initState() {
    super.initState();
    _initAnimations();

    Future.delayed(const Duration(seconds: 3), () {
      _startWave();
      _periodicTimer = Timer.periodic(
        const Duration(seconds: 30),
        (_) => _startWave(),
      );
    });
  }

  void _initAnimations() {
    for (int i = 0; i < _text.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
      final animation = Tween<double>(
        begin: 0.0,
        end: -10.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
      _controllers.add(controller);
      _animations.add(animation);
    }
  }

  void _startWave() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) _controllers[i].forward(from: 0.0);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _periodicTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_text.length, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animations[index].value),
              child: Text(
                _text[index],
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  shadows: [
                    Shadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

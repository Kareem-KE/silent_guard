import 'package:flutter/material.dart';

class AnimatedTitle extends StatelessWidget {
  final String text;
  final Animation<double> animation;

  const AnimatedTitle({super.key, required this.text, required this.animation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 40,
      child: ScaleTransition(
        scale: animation,
        child: Text(text, style: theme.textTheme.bodyMedium?.copyWith()),
      ),
    );
  }
}

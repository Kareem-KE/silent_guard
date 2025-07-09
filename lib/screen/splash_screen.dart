import 'dart:async';
import 'package:flutter/material.dart';
import 'package:silent_guard/screen/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  double _progress = 0.0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startProgressSimulation();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  void _startProgressSimulation() {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      setState(() {
        _progress += 0.02;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _progressTimer?.cancel();
          _navigateToHome();
        }
      });
    });
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF006a4e),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnimatedLogo(),
              const SizedBox(height: 30),
              _buildProgressBar(),
              const SizedBox(height: 10),
              _buildLoadingText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          height: 160,
          width: 160,
          child: Image.asset('assets/Images/logo.png'),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: _progress,
      minHeight: 10,
      backgroundColor: Colors.black,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }

  Widget _buildLoadingText(BuildContext context) {
    return Text(
      'Loading ${(_progress * 100).toInt()}%',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}

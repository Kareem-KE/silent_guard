import 'package:flutter/material.dart';
import 'package:silent_guard/screen/heart_view.dart';
import 'package:silent_guard/widget/custom_app_bar.dart';
import 'package:silent_guard/widget/custom_navigation_bar.dart';
import 'package:silent_guard/widget/home_screen_content.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreenContent(),
    HeartView(),
    Center(child: Text("Profile", style: TextStyle(fontSize: 24))),
    Center(child: Text("Settings", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

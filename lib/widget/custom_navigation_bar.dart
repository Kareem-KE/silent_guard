import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// ignore: unused_element
class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color navBarColor = Color(0xFF006a4e);
  static const Color iconColor = Colors.white;
  static const Color selectedColor = Colors.white;
  static const String fontFamily = 'Agbalumo';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: navBarColor,
      ),
      child: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          _buildNavItem(Icons.home, "Home"),
          _buildNavItem(Icons.monitor_heart, "Heart"),
          _buildNavItem(Icons.person, "Profile"),
        ],
      ),
    );
  }

  SalomonBottomBarItem _buildNavItem(IconData icon, String title) {
    return SalomonBottomBarItem(
      icon: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontFamily: fontFamily)),
      selectedColor: selectedColor,
    );
  }
}

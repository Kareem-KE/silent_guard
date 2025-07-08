import 'package:flutter/material.dart';
import 'package:silent_guard/screen/splash_screen.dart';
import 'package:silent_guard/settings/help_support.dart';
import 'package:silent_guard/settings/privacy_screen.dart';
import 'package:silent_guard/widget/settings_card.dart';
import 'package:silent_guard/widget/settings_item.dart';
import 'package:silent_guard/widget/settings_section_title.dart';

class SettingsScreen extends StatelessWidget {
  final int userId;

  const SettingsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 100,
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SettingsSectionTitle(title: 'Account'),
              SettingsCard(
                children: [
                  SettingsItem(
                    icon: Icons.person_outline,
                    title: 'Account',
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.notifications_active_outlined,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              SettingsSectionTitle(title: 'support'),
              SettingsCard(
                children: [
                  SettingsItem(
                    icon: Icons.lock_outline,
                    title: 'privacy',
                    onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyScreen(),
                        ),
                      );},
                  ),
                  SettingsItem(
                    icon: Icons.question_mark_rounded,
                    title: 'help support',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpSupportScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const SettingsSectionTitle(title: 'Actions'),
              SettingsCard(
                children: [
                  SettingsItem(
                    icon: Icons.logout_outlined,
                    title: 'Logout',
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

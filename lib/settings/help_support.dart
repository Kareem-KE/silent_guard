import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  void _launchEmail() async {
    const url =
        "https://outlook.live.com/mail/0/deeplink/compose?to=kareemelsayed0678@gmail.com";
    final launched = await launchUrlString(url);
    if (!launched) {
      debugPrint(" Could not open Outlook.");
    }
  }

  void _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse("https://wa.me/201040797896");

    if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
      debugPrint(' Could not launch WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.appBarTheme.foregroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 100,
        title: Text('Help & Support', style: theme.appBarTheme.titleTextStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Need Assistance?',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 10,
              color: theme.cardColor,
              shadowColor: theme.shadowColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 5.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'If you have any questions or need help using the app, feel free to contact us through the following methods:',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Color(0xFF042D46),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.email, color: theme.iconTheme.color),
                      title: Text(
                        'kareemelsayed0678@gmail.com',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      onTap: _launchEmail,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        'assets/Icons/whatsapp.svg',
                        width: 24,
                        height: 24,
                      ),
                      title: Text(
                        '+20 1040797896',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      onTap: _launchWhatsApp,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'You can access the FAQ section or contact us directly. Our team will get back to you as soon as possible.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Color(0xFF042D46),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:silent_guard/widget/notification_appbar.dart';
import 'package:silent_guard/widget/notification_header.dart';
import 'package:silent_guard/widget/notification_items.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  DateTime? lastNotificationTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      lastNotificationTime = DateTime.now();
    });
  }

  String getTimeAgo() {
    if (lastNotificationTime == null) return '—';
    final diff = DateTime.now().difference(lastNotificationTime!);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NotificationAppBar(),
      body: Column(
        children: [
          const NotificationHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NotificationItem(
                    icon: Icons.favorite_border,
                    title: 'Heart Rate Alert',
                    subtitle:
                        'Check if your child is healthy or feeling unwell.',
                    time: lastNotificationTime != null ? getTimeAgo() : '—',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

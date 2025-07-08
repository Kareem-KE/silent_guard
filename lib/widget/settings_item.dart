import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.textTheme.bodyMedium?.color, 
            ),
            const SizedBox(width: 16.0),
            Expanded(child: Text(title, style: theme.textTheme.bodyMedium)),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  color: theme.colorScheme.onPrimary,
                ),
          ],
        ),
      ),
    );
  }
}

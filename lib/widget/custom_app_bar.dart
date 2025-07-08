import 'package:flutter/material.dart';
import 'package:silent_guard/screen/settings_screen.dart';
import 'package:silent_guard/widget/animation_text_appbar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF006a4e), width: 3.5),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                'assets/Images/zachary-kyra-derksen-0bDd5rZlZmk-unsplash.jpg',
              ),
            ),
          ),
          SizedBox(width: 20),

          AnimationTextAppbar(),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_on_outlined,
                  size: 30,
                  color: theme.colorScheme.primary,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(userId: 1),
                    ),
                  );
                },
                icon: Icon(
                  Icons.settings_suggest_rounded,
                  size: 30,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

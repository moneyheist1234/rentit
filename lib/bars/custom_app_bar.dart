// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:rentit/constants.dart';
import 'package:rentit/menu/profile_menu_actions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kThemeColor,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Center(
        child: Image.asset(
          'assets/images/logo/rentlogoo.png',
          width: 120.0,
          height: 60.0,
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_outlined), // Profile icon
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {
            // Show the popup menu
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                MediaQuery.of(context).size.width - 100,
                kToolbarHeight,
                0.0,
                0.0,
              ),
              items: [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.person_2_rounded, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Profile'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Share'),
                    ],
                  ),
                ),
              ],
              elevation: 8.0,
            ).then((value) {
              if (value != null) {
                onMenuSelected(context, value); // Call the function
              }
            });
          },
        ),
        const SizedBox(width: 20),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:rentit/constants.dart';
import '../screens/profile.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function(BuildContext context, int value) onMenuSelected;

  const ProductAppBar({
    Key? key,
    required this.title,
    required this.onMenuSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kThemeColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        // IconButton(
        //   icon: const Icon(Icons.account_circle_outlined),
        //   iconSize: 30.0,
        //   color: Colors.white,
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const Profile()),
        //     );
        //   },
        // ),
        IconButton(
          icon: const Icon(Icons.share),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Share selected')),
            );
            // Add actual share functionality here if required.
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

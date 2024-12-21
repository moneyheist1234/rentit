import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem(
      {super.key,
      required this.name,
      required this.icon,
      required this.onPressed});

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 40),
            Text(
              name,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

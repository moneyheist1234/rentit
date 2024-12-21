import 'package:flutter/material.dart';

class CallFab extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor; // Added backgroundColor parameter

  const CallFab(
      {Key? key, required this.onPressed, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5.0,
      onPressed: onPressed,
      child: const Icon(
        Icons.call,
        size: 30.0,
      ),
      backgroundColor: backgroundColor, // Use the passed backgroundColor
      foregroundColor: Colors.black,
    );
  }
}

// lib/widgets/custom_fab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFAB extends StatelessWidget {
  final Widget targetScreen;

  const CustomFAB({
    Key? key,
    required this.targetScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5.0,
      onPressed: () {
        // Using GetX navigation instead of Navigator for better integration
        Get.to(
          () => targetScreen,
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.white70,
            ],
          ),
        ),
        child: const Icon(
          Icons.add, // Changed to add icon since this is for adding rentals
          size: 30.0,
          color: Colors.black87,
        ),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
    );
  }
}

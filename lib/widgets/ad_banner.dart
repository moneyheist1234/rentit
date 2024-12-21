import 'package:flutter/material.dart';

class BannerAdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150.0, // Adjust the height as needed
      color: Colors.blueGrey, // Placeholder for ad background
      alignment: Alignment.center,
      child: const Text(
        'Google Ad',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SearchingBar extends StatelessWidget {
  const SearchingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Adjust padding as needed
      child: Material(
        elevation: 4.0, // Add elevation to create a shadow effect
        borderRadius: BorderRadius.circular(30.0), // Match the border radius
        child: TextField(
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Adjust padding for the icon
              child: Icon(
                Icons.search,
                color: const Color(0xFF4B5AA8),
              ),
            ),
            hintText: 'Search...',
            contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0), // Adjust padding to fit the hint text
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Curved edges
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

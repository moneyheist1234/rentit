import 'package:flutter/material.dart';

class PaginationDots extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color dotColor;

  PaginationDots({
    required this.currentPage,
    required this.totalPages,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: currentPage == index ? 16 : 8, // Adjust size for current page
          height: 8, // Keep height consistent
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius:
                BorderRadius.circular(4), // Adjust for consistent rounding
          ),
        );
      }),
    );
  }
}

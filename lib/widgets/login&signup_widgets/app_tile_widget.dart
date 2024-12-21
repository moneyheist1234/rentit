import 'package:flutter/material.dart';

class AppTitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const AppTitleWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Be Vietnam',
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Be Vietnam',
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

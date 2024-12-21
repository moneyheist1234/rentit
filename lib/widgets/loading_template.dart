// widgets/loading_dialog.dart
import 'package:flutter/material.dart';
import 'package:rentit/constants.dart';

class LoadingDialog extends StatelessWidget {
  final Color color;

  const LoadingDialog({
    Key? key,
    this.color = kThemeColor, // Default color can be modified
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 4,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
            SizedBox(height: 15),
            Text(
              'Please wait...',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontFamily: 'Be Vietnam',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

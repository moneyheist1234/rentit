import 'package:flutter/material.dart';
import 'package:rentit/screens/profile.dart';
import 'package:rentit/screens/sharelink.dart';

void onMenuSelected(BuildContext context, int value) {
  switch (value) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Sharelink()),
      );
      break;
    default:
      break;
  }
}

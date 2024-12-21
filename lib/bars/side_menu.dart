import 'package:flutter/material.dart';

import 'package:rentit/pages/my_rental_items.dart';
import 'package:rentit/pages/ownership.dart';
import 'package:rentit/pages/phone_number.dart';
import 'package:rentit/pages/reviews.dart';
import 'package:rentit/pages/help_and_support.dart';
import 'package:rentit/pages/signout.dart';
import 'package:rentit/pages/settings.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            // Header with rounded circle avatar
            Container(
              width: double.infinity,
              height: 250.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[900]!,
                    Colors.blue[900]!
                  ], // Single color gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80.0, // Adjust the size as needed
                    backgroundImage: AssetImage(
                        'assets/images/sidemenu/side_menu_avator.png'),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            // Divider
            Divider(height: 50, color: Colors.grey[300]),

            // Menu items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildMenuItem(
                    context,
                    name: 'My Rental Items',
                    icon: Icons.store,
                    index: 0,
                  ),
                  buildMenuItem(
                    context,
                    name: 'Ownership',
                    icon: Icons.add_business_rounded,
                    index: 1,
                  ),
                  buildMenuItem(
                    context,
                    name: 'Reviews',
                    icon: Icons.star_border,
                    index: 2,
                  ),
                  buildMenuItem(
                    context,
                    name: 'My Phone Number',
                    icon: Icons.phone,
                    index: 3,
                  ),
                  buildMenuItem(
                    context,
                    name: 'Help and Support',
                    icon: Icons.support_agent,
                    index: 4,
                  ),
                  buildMenuItem(
                    context,
                    name: 'Settings',
                    icon: Icons.settings,
                    index: 5,
                  ),
                  buildMenuItem(
                    context,
                    name: 'Log Out',
                    icon: Icons.logout_outlined,
                    index: 6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    required String name,
    required IconData icon,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Material(
        elevation: 5.0, // Add elevation to create a shadow effect
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        color: Colors.blue[900], // Background color for items
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            name,
            style: TextStyle(
              color: Colors.white, // Set text color to white
              fontWeight: FontWeight.w500, // Optional: make text semi-bold
            ),
          ),
          onTap: () => onItemPressed(context, index: index),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context); // Close the drawer

    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyRentalItems()));
        break;

      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Ownership()));
        break;

      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Reviews()));
        break;

      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PhoneNumber()));
        break;

      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HelpAndSupport()));
        break;

      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Settings()));
        break;

      case 6:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Signout()));
        break;

      default:
        Navigator.pop(context);
        break;
    }
  }
}

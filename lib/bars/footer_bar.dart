import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentit/screens/home.dart';
import 'package:rentit/screens/profile.dart';
import 'package:rentit/screens/search.dart';
import 'package:rentit/screens/favorites.dart';

import 'package:rentit/controllers/footer_controller.dart'; // Make sure to import the controller

class FooterBar extends StatelessWidget {
  final FooterController footerController = Get.put(FooterController());

  FooterBar({super.key});

  final List<Widget> pages = [
    Home(),
    const Search(),
    const Favorites(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildIconWithLabel(
            context,
            icon: Icons.home_outlined,
            filledIcon: Icons.home,
            label: 'Home',
            index: 0,
          ),
          _buildIconWithLabel(
            context,
            icon: Icons.search_outlined,
            filledIcon: Icons.security_rounded,
            label: 'Search',
            index: 1,
          ),
          _buildIconWithLabel(
            context,
            icon: Icons.favorite_outline,
            filledIcon: Icons.favorite,
            label: 'Favorites',
            index: 2,
          ),
          _buildIconWithLabel(
            context,
            icon: Icons.person_2_outlined,
            filledIcon: Icons.person_2_rounded,
            label: 'Profile',
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithLabel(
    BuildContext context, {
    required IconData icon,
    required IconData filledIcon,
    required String label,
    required int index,
  }) {
    return InkWell(
      onTap: () => _navigateTo(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Wrapping the icon in an Obx to watch the reactive currentIndex
          Obx(() => Icon(
                footerController.currentIndex.value == index
                    ? filledIcon
                    : icon,
                color: Colors.white,
              )),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _navigateTo(int index) {
    footerController.updateIndex(index); // Update the current index
    Get.off(pages[index]); // Navigate to the selected page
  }
}

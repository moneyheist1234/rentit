import 'package:flutter/material.dart';
import 'package:rentit/screens/rent_adding_form.dart';

import '../bars/custom_app_bar.dart';
import '../bars/custom_fab.dart';
import '../bars/footer_bar.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(),
      body: Center(
        child: Text('fav from navbar'),
      ),
      bottomNavigationBar: FooterBar(),
      floatingActionButton: CustomFAB(
        targetScreen: RentAddingForm(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rentit/bars/custom_app_bar.dart';
import 'package:rentit/bars/footer_bar.dart';
import 'package:rentit/bars/custom_fab.dart';
import 'package:rentit/screens/rent_adding_form.dart';
import 'package:rentit/widgets/search_bar.dart';
import 'package:rentit/widgets/dropdownlist.dart';
import 'package:rentit/bars/side_menu.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchingBar(),
              SizedBox(
                width: 20.0,
              ),
              DropdownList(),
              // GridViewHome(),
            ],
          ),
        ),
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

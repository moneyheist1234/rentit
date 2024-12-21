import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentit/screens/rent_adding_form.dart';
import '../bars/custom_app_bar.dart';
import '../bars/custom_fab.dart';
import '../bars/footer_bar.dart';
import '../bars/side_menu.dart';
import '../constants.dart';
import '../controllers/home_controller.dart';
import '../widgets/carousel.dart';
import '../widgets/grid_view_home.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CustomAppBar(),
      body: Obx(() {
        print("Is Loading: ${controller.isLoading.value}"); // Debug log
        return controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: kThemeColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const Carousel(),
                    const GridViewHome(),
                  ],
                ),
              );
      }),
      bottomNavigationBar: FooterBar(),
      floatingActionButton: CustomFAB(
        targetScreen: RentAddingForm(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}

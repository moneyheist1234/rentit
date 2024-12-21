import 'package:get/get.dart';

class FooterController extends GetxController {
  // Reactive index for the current page
  var currentIndex = 0.obs;

  // Update the current index
  void updateIndex(int index) {
    currentIndex.value = index;
  }
}

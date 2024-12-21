// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../authentication/authentication.dart';
// import '../screens/login&signup/login_screen.dart';
// import '../widgets/loading_template.dart';
//
// class SignupController extends GetxController {
//   static SignupController get instance => Get.find();
//
//   final AuthenticationRepository _auth = Get.find<AuthenticationRepository>();
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final isLoading = false.obs;
//
//   void registerUser(String email, String password) async {
//     if (email.isEmpty || password.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please fill all fields',
//         backgroundColor: Colors.red.withOpacity(0.1),
//         colorText: Colors.red,
//       );
//       return;
//     }
//
//     if (!GetUtils.isEmail(email)) {
//       Get.snackbar(
//         'Error',
//         'Please enter a valid email',
//         backgroundColor: Colors.red.withOpacity(0.1),
//         colorText: Colors.red,
//       );
//       return;
//     }
//
//     if (password.length < 6) {
//       Get.snackbar(
//         'Error',
//         'Password must be at least 6 characters',
//         backgroundColor: Colors.red.withOpacity(0.1),
//         colorText: Colors.red,
//       );
//       return;
//     }
//
//     isLoading.value = true;
//     await _auth.createUserWithEmailAndPassword(email, password);
//     isLoading.value = false;
//   }
//
//   // @override
//   // void onClose() {
//   //   email.dispose();
//   //   password.dispose();
//   //   super.onClose();
//   // }
// }

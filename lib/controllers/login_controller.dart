// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../authentication/authentication.dart';
// import '../screens/home.dart';
// import '../widgets/loading_template.dart';
//
// class LoginController extends GetxController {
//   static LoginController get instance => Get.find();
//
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final AuthenticationRepository _authRepo =
//       Get.find<AuthenticationRepository>();
//   final isLoading = false.obs;
//
//   void loginUser() async {
//     try {
//       String email = emailController.text.trim();
//       String password = passwordController.text.trim();
//
//       // Validation checks
//       if (email.isEmpty || password.isEmpty) {
//         _showErrorSnackbar(
//             'Required Fields', 'Please fill in all fields to continue');
//         return;
//       }
//
//       if (!GetUtils.isEmail(email)) {
//         _showErrorSnackbar(
//             'Invalid Email', 'Please enter a valid email address');
//         return;
//       }
//
//       isLoading.value = true;
//       _showLoadingDialog();
//
//       // Attempt login
//       await _authRepo.loginWithEmailAndPassword(email, password);
//
//       // Clear fields after successful login
//       emailController.clear();
//       passwordController.clear();
//     } catch (error) {
//       Get.back(); // Close loading dialog
//       _handleLoginError(error);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void _handleLoginError(dynamic error) {
//     if (error is FirebaseAuthException) {
//       switch (error.code) {
//         case 'user-not-found':
//           _showErrorSnackbar(
//               'Account Not Found', 'No account exists with this email');
//           break;
//         case 'wrong-password':
//           _showErrorSnackbar(
//               'Invalid Password', 'The password you entered is incorrect');
//           break;
//         case 'invalid-email':
//           _showErrorSnackbar(
//               'Invalid Email', 'Please enter a valid email address');
//           break;
//         case 'user-disabled':
//           _showErrorSnackbar(
//               'Account Disabled', 'This account has been disabled');
//           break;
//         case 'too-many-requests':
//           _showErrorSnackbar('Too Many Attempts',
//               'Too many failed attempts. Please try again later');
//           break;
//         default:
//           _showErrorSnackbar(
//               'Login Failed', 'Please check your credentials and try again');
//       }
//     } else {
//       _showErrorSnackbar(
//           'Error', 'An unexpected error occurred. Please try again');
//     }
//   }
//
//   void _showLoadingDialog() {
//     Get.dialog(
//       LoadingDialog(),
//       barrierDismissible: false,
//     );
//   }
//
//   void _showErrorSnackbar(String title, String message) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red.withOpacity(0.1),
//       colorText: Colors.red,
//       duration: const Duration(seconds: 3),
//       margin: const EdgeInsets.all(10),
//       borderRadius: 10,
//       icon: const Icon(Icons.error_outline, color: Colors.red),
//     );
//   }
//
//   void _showSuccessSnackbar(String title, String message) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green.withOpacity(0.1),
//       colorText: Colors.green,
//       duration: const Duration(seconds: 3),
//       margin: const EdgeInsets.all(10),
//       borderRadius: 10,
//       icon: const Icon(Icons.check_circle, color: Colors.green),
//     );
//   }
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }

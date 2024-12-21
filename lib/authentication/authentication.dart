// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:rent_it/screens/login&signup/login_screen.dart';
// import 'package:rent_it/screens/splash_screen/splash_screen.dart';
// import '../screens/home.dart';
//
// class AuthenticationRepository extends GetxController {
//   static AuthenticationRepository get instance => Get.find();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late final Rx<User?> firebaseUser;
//
//   @override
//   void onReady() {
//     super.onReady();
//     firebaseUser = Rx<User?>(_auth.currentUser);
//     firebaseUser.bindStream(_auth.userChanges());
//     ever(firebaseUser, _setInitialScreen);
//     print(
//         "Firebase authentication initialized. Current user: ${_auth.currentUser}");
//   }
//
//   void _setInitialScreen(User? user) {
//     print("Setting initial screen. Current route: ${Get.currentRoute}");
//     if (user == null && Get.currentRoute != '/login') {
//       print("Navigating to LoginScreen");
//       Get.offAll(() => LoginScreen());
//     } else if (user != null && Get.currentRoute != '/home') {
//       print("Navigating to Home screen");
//       Get.offAll(() => Home());
//     }
//   }
//
//   // Future<void> createUserWithEmailAndPassword(String email, String password) async {
//   //   try {
//   //     var methods = await _auth.fetchSignInMethodsForEmail(email);
//   //     if (methods.isNotEmpty) {
//   //       _showSnackbar('Error', 'Email already exists. Please login instead.');
//   //       return;
//   //     }
//   //
//   //     await _auth.createUserWithEmailAndPassword(email: email, password: password);
//   //     Get.offAll(() => SplashScreen());
//   //   } on FirebaseAuthException catch (e) {
//   //     _handleAuthError(e);
//   //   }
//   // }
//   //
//   // Future<void> loginWithEmailAndPassword(String email, String password) async {
//   //   try {
//   //     await _auth.signInWithEmailAndPassword(email: email, password: password);
//   //     if (_auth.currentUser != null) {
//   //       Get.offAll(() => Home());
//   //     }
//   //   } on FirebaseAuthException catch (e) {
//   //     _handleAuthError(e);
//   //   }
//   // }
//
//   Future<void> logout() async {
//     try {
//       await _auth.signOut();
//       Get.offAll(() => SplashScreen());
//     } catch (e) {
//       _showSnackbar('Error', 'Failed to logout');
//     }
//   }
//
//   void _showSnackbar(String title, String message) {
//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: Colors.red.withOpacity(0.1),
//       colorText: Colors.red,
//       duration: Duration(seconds: 3),
//     );
//   }
//
//   void _handleAuthError(FirebaseAuthException e) {
//     String message;
//     switch (e.code) {
//       case 'weak-password':
//         message = 'Password is too weak.';
//         break;
//       case 'email-already-in-use':
//         message = 'Email already exists. Please login instead.';
//         break;
//       case 'invalid-email':
//         message = 'Invalid email address.';
//         break;
//       case 'user-not-found':
//         message = 'No user found with this email.';
//         break;
//       case 'wrong-password':
//         message = 'Wrong password.';
//         break;
//       case 'user-disabled':
//         message = 'This account has been disabled.';
//         break;
//       default:
//         message = 'An error occurred. Please try again.';
//     }
//     _showSnackbar('Error', message);
//   }
// }

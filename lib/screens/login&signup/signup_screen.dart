// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../authentication/google_sign_service.dart';
// import '../../controllers/signup_controller.dart';
// import '../../widgets/login&signup_widgets/custom_button_widget.dart';
// import '../../widgets/login&signup_widgets/custom_text_field_widget.dart';
// import '../../widgets/login&signup_widgets/header_widget.dart';
// import '../../widgets/login&signup_widgets/signup_text_widget.dart';
// import '../../widgets/login&signup_widgets/social_login_widget.dart';
// import '../home.dart';
// import 'login_screen.dart';
//
// class SignUpScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SignupController());
//     final googleSignInService = Get.put(GoogleSignInService());
//     final _formKey = GlobalKey<FormState>();
//
//     // Define a controller for the password input
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         toolbarHeight: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 HeaderWidget(title: 'Rent IT', subtitle: 'Sign Up!'),
//                 SizedBox(height: 20),
//                 SignUpTextWidget(
//                   questionText: 'Already have an account? ',
//                   actionText: 'Login',
//                   onActionTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 30),
//
//                 // Full Name Field
//
//                 // Email Address Field
//                 CustomTextFieldWidget(
//                   controller: controller.email,
//                   hintText: 'Email Address',
//                   iconPath: 'assets/icons/email.png',
//                 ),
//
//                 // Phone Number Field
//                 // CustomTextFieldWidget(
//                 //   controller: controller.phoneNo,
//                 //   hintText: 'Phone Number',
//                 //   iconPath: 'assets/icons/phone_icon.png',
//                 // ),
//                 SizedBox(height: 20),
//
//                 // Password Field
//                 CustomTextFieldWidget(
//                   controller: controller.password,
//                   hintText: 'Password',
//                   iconPath: 'assets/icons/password.png',
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 20),
//
//                 // Sign Up Button
//                 // Your existing SignUpScreen code with these changes in the CustomButtonWidget:
//
//                 CustomButtonWidget(
//                   text: 'Sign Up',
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       SignupController.instance.registerUser(
//                         controller.email.text.trim(),
//                         controller.password.text.trim(),
//                       );
//                     }
//                   },
//                 ),
//
//                 SizedBox(height: 20),
//                 Center(
//                   child: Text(
//                     'or sign up with',
//                     style: TextStyle(
//                       color: Color(0x4C261C12),
//                       fontSize: 10,
//                       fontFamily: 'Be Vietnam',
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Social Login Row with Scrollable Feature
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 120.0),
//                         child: SocialLoginWidget(
//                           iconPath: 'assets/icons/google_icon.png',
//                           onTap: () async {
//                             final userCredential =
//                                 await googleSignInService.signInWithGoogle();
//                             if (userCredential != null) {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => Home()),
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                       //   child: SocialLoginWidget(
//                       //     iconPath: 'assets/icons/phone_icon.png',
//                       //     onTap: () {
//                       //       Navigator.push(
//                       //         context,
//                       //         MaterialPageRoute(
//                       //           builder: (context) => PhoneNumberLoginScreen(),
//                       //         ),
//                       //       );
//                       //     },
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

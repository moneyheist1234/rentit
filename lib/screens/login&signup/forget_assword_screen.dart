// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:rent_it/constants.dart';
// import 'package:rent_it/screens/login&signup/phone_number_login_screen.dart';
//
// import '../../widgets/login&signup_widgets/app_tile_widget.dart';
// import '../../widgets/login&signup_widgets/custom_button_widget.dart';
// import '../../widgets/login&signup_widgets/custom_text_field_widget.dart';
// import '../home.dart';
// import 'login_screen.dart';
//
// class ForgotPasswordScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 60),
//               // Reusing the AppTitleWidget for the app title
//               AppTitleWidget(title: 'Rent IT', subtitle: ''),
//               SizedBox(height: 70),
//               Text(
//                 'Forgot Password?',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: 'Be Vietnam',
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 20),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Remember your password?  ',
//                       style: TextStyle(
//                         color: Colors.black.withOpacity(0.3),
//                         fontSize: 14,
//                         fontFamily: 'Be Vietnam',
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Login',
//                       style: TextStyle(
//                         color: kThemeColor,
//                         fontSize: 14,
//                         fontFamily: 'Be Vietnam',
//                         fontWeight: FontWeight.w500,
//                       ),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginScreen()),
//                           ); // Navigate back to login
//                         },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 60),
//               // Reusing the custom text field widget for the phone number
//               // CustomTextFieldWidget(
//               //   hintText: 'Phone Number',
//               //   iconPath: 'assets/icons/phone_icon.png',
//               // ),
//               SizedBox(height: 30),
//               // Reusing the custom button widget for sending the code
//               CustomButtonWidget(
//                 text: 'Send Code',
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PhoneNumberLoginScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

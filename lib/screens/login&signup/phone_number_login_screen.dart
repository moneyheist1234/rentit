// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:rent_it/constants.dart';
//
// import '../../authentication/authentication.dart';
// import '../../widgets/login&signup_widgets/app_tile_widget.dart';
// import '../../widgets/login&signup_widgets/custom_button_widget.dart';
//
// import 'login_screen.dart';
// import 'otp_verification_screen.dart';
//
// class PhoneNumberLoginScreen extends StatefulWidget {
//   @override
//   State<PhoneNumberLoginScreen> createState() => _PhoneNumberLoginScreenState();
// }
//
// class _PhoneNumberLoginScreenState extends State<PhoneNumberLoginScreen> {
//   final phoneController = TextEditingController();
//   final authRepo = AuthenticationRepository.instance;
//
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
//               AppTitleWidget(title: 'Rent IT', subtitle: ''),
//               SizedBox(height: 70),
//               Text(
//                 'Phone Login',
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
//                       text: 'Already have an account?  ',
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
//                         ..onTap = () => Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginScreen()),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 60),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF2F2F2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         '+91',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 1,
//                       height: 30,
//                       color: Colors.grey.withOpacity(0.5),
//                     ),
//                     Expanded(
//                       child: TextField(
//                         controller: phoneController,
//                         keyboardType: TextInputType.number,
//                         maxLength: 10,
//                         decoration: InputDecoration(
//                           hintText: 'Enter 10 digit number',
//                           border: InputBorder.none,
//                           counterText: '',
//                           contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               CustomButtonWidget(
//                 text: 'Send OTP',
//                 onPressed: () async {
//                   if (phoneController.text.isEmpty ||
//                       phoneController.text.length != 10) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                           content: Text('Please enter 10 digit phone number')),
//                     );
//                     return;
//                   }
//                   String fullPhoneNumber = '+91${phoneController.text}';
//                   await authRepo.phoneAuthentication(fullPhoneNumber);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => VerifyOTPScreen(
//                         phoneNumber: fullPhoneNumber,
//                       ),
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
//
//   @override
//   void dispose() {
//     phoneController.dispose();
//     super.dispose();
//   }
// }

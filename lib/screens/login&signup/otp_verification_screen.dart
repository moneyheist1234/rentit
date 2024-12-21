// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:rent_it/constants.dart';
// import '../../authentication/authentication.dart';
// import '../../widgets/login&signup_widgets/app_tile_widget.dart';
// import '../../widgets/login&signup_widgets/custom_button_widget.dart';
// import '../home.dart';
// import 'login_screen.dart';
//
// class VerifyOTPScreen extends StatefulWidget {
//   final String phoneNumber;
//
//   const VerifyOTPScreen({Key? key, required this.phoneNumber})
//       : super(key: key);
//
//   @override
//   State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
// }
//
// class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
//   final List<TextEditingController> otpControllers =
//       List.generate(5, (index) => TextEditingController());
//   final authRepo = AuthenticationRepository.instance;
//
//   String get otp => otpControllers.map((e) => e.text).join();
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
//                 'Verify OTP',
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
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(
//                   5,
//                   (index) => buildOTPField(context, index),
//                 ),
//               ),
//               SizedBox(height: 30),
//               CustomButtonWidget(
//                 text: 'Submit',
//                 onPressed: () async {
//                   if (otp.length != 5) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Please enter complete OTP')),
//                     );
//                     return;
//                   }
//
//                   bool verified = await authRepo.verifyOTP(otp);
//                   if (verified) {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => Home()),
//                     );
//                   }
//                 },
//               ),
//               SizedBox(height: 20),
//               Center(
//                 child: GestureDetector(
//                   onTap: () async {
//                     await authRepo.phoneAuthentication(widget.phoneNumber);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('OTP resent successfully')),
//                     );
//                   },
//                   child: Text(
//                     'Resend Code',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildOTPField(BuildContext context, int index) {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Color(0xFFF2F2F2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TextFormField(
//         controller: otpControllers[index],
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//         maxLength: 1,
//         decoration: InputDecoration(
//           counterText: '',
//           border: InputBorder.none,
//         ),
//         onChanged: (value) {
//           if (value.length == 1 && index < 4) {
//             FocusScope.of(context).nextFocus();
//           }
//           if (value.isEmpty && index > 0) {
//             FocusScope.of(context).previousFocus();
//           }
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     for (var controller in otpControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }

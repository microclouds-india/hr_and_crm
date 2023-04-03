// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:hr_and_crm/common/widgets/submitContainer.dart';
// import 'package:hr_and_crm/ui/login%20Screens/Otp/OTPscreen.dart';
// import 'package:hr_and_crm/ui/login%20Screens/numberScreen.dart';

// import '../../common/widgets/appbarTXT.dart';
// import '../../common/widgets/bookingFormTextFields.dart';

// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({super.key});

//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   bool number = false;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Colors.pink.shade900,
//           title: apBarText(
//             'Forgot Password',
//             Colors.white,
//           ),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//           child: Column(
//             children: [
//               Center(
//                 child: Image.asset(
//                   "assets/icons/logo.png",
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: Text(
//                   'Please Enter Your Email Address To',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               Center(
//                 child: Text('Recive a Verification Code',
//                     style:
//                         TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
//               ),

//               // Center(
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children: [
//               //       GestureDetector(
//               //         onTap: () {
//               //           setState(() {
//               //             number = false;
//               //           });
//               //         },
//               //         child: Container(
//               //           height: 50,
//               //           width: 100,
//               //           decoration: BoxDecoration(
//               //               border: Border.all(color: Colors.grey),
//               //               borderRadius:
//               //                   BorderRadius.all(Radius.circular(20))),
//               //           child: Center(
//               //             child: Text('Email'),
//               //           ),
//               //         ),
//               //       ),
//               //       SizedBox(
//               //         width: 20,
//               //       ),
//               //       Container(
//               //         height: 50,
//               //         width: 100,
//               //         decoration: BoxDecoration(
//               //             border: Border.all(color: Colors.grey),
//               //             borderRadius: BorderRadius.all(Radius.circular(20))),
//               //         child: Center(
//               //           child: Text('Phone'),
//               //         ),
//               //       )
//               //     ],
//               //   ),
//               // ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: BookingFormTextFields(
//                   hint: 'Emter your email',
//                   maxLines: 1,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 30, right: 30),
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return ForgotOTPscreen();
//                       }));
//                     },
//                     child: submitContainer(context, 'Verify')),
//               ),
//               Spacer(),
//               TextButton(
//                   onPressed: () => Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(builder: (context) {
//                         return NumberForgotScreen();
//                       })),
//                   child: Text(
//                     'Try another way',
//                     style: TextStyle(color: Colors.pink.shade900),
//                   )),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

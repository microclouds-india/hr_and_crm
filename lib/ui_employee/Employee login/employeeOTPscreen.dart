// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:hr_and_crm/common/widgets/submitContainer.dart';
// import 'package:hr_and_crm/repository/Employee%20login/employeeLogin.dart';
// import 'package:hr_and_crm/ui/home/tabs/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../common/widgets/appbarTXT.dart';
// import '../../ui/home/homeScreen.dart';

// class EmployeeOTPscreen extends StatefulWidget {
//   String number;
//   EmployeeOTPscreen({required this.number});

//   @override
//   State<EmployeeOTPscreen> createState() => _EmployeeOTPscreenState();
// }

// class _EmployeeOTPscreenState extends State<EmployeeOTPscreen> {
//   String otpVerifivationCode = '';
//   String? _verificationCode;
//   bool resendOTP = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     EmployeeLoginNetWork().getOTP(widget.number);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Colors.pink.shade900,
//           title: apBarText(
//             'Verify your OTP',
//             Colors.white,
//           ),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
//               const SizedBox(
//                 height: 40,
//               ),
//               Center(
//                   child: Text(
//                 'Please Enter The 4 Digit Code Send To',
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               )),
//               Center(
//                 child: Text(
//                   '+91 ${widget.number}',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               OtpTextField(
//                 focusedBorderColor: Colors.pink.shade900,
//                 fillColor: Colors.pink.shade900,
//                 numberOfFields: 4,
//                 borderColor: Colors.pink.shade900,
//                 //set to true to show as box or false to show as dash
//                 showFieldAsBox: true,
//                 //runs when a code is typed in
//                 onCodeChanged: (String code) {
//                   //handle validation or checks here
//                 },
//                 //runs when every textfield is filled
//                 onSubmit: (String verificationCode) {
//                   otpVerifivationCode = verificationCode;
//                   print(otpVerifivationCode);
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: TextButton(
//                     onPressed: () {
//                       setState(() {
//                         resendOTP = true;

//                         Timer(Duration(seconds: 30), () {
//                           setState(() {
//                             resendOTP = false;
//                           });
//                         });
//                       });
//                     },
//                     child: Text(
//                       'Resend OTP!',
//                       style: TextStyle(
//                           color: resendOTP ? Colors.grey : Colors.pink.shade900,
//                           fontWeight: FontWeight.bold),
//                     )),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20),
//                 child: GestureDetector(
//                     onTap: () async {
//                       final prif = await SharedPreferences.getInstance();
//                       EmployeeLoginNetWork().existuserOtp(
//                           otpVerifivationCode, context, widget.number);
//                     },
//                     child: submitContainer(context, 'Verify')),
//               ),
//               Spacer(),
//               TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text(
//                     'Change number!',
//                     style: TextStyle(
//                       color: Colors.pink.shade900,
//                     ),
//                   )),
//               Spacer()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

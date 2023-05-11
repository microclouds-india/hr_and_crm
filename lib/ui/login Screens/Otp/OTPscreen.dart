import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/widgets/appbarTXT.dart';

// ignore: must_be_immutable
class OTPscreen extends StatefulWidget {
  String number;
  // ignore: use_key_in_widget_constructors
  OTPscreen({required this.number});

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  String otpVerifivationCode = '';
  String? _verificationCode;
  bool resendOTP = false;
  indexOtp() async {
    EasyLoading.show(status: 'Loading...');
    var url = Uri.parse('https://cashbes.com/attendance/login/index');
    var response = await http.post(url, body: {'phone': widget.number});
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      // _listenForCode();
    } else {
      EasyLoading.dismiss();
      print(response.statusCode);
    }
  }

  existuserOtp(String otp) async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse('https://cashbes.com/attendance/login/existuser_otp');
    var response =
        await http.post(url, body: {'phone': widget.number, 'otp': otp});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final prif = await SharedPreferences.getInstance();
      prif.setString('token', data['token']);
      print('newTikeeeeeeeen${data['token']}');
      print('Roleeeeeeeeeeeeee${data['job_role']}');
      prif.setString('role', data['job_role']);
      if (prif.getString('role') == null ||
          prif.getString('role')!.isEmpty ||
          prif.getString('role') == '0') {
        // ignore: use_build_context_synchronously
        Ui.getSnackBar(title: 'no such user exists', context: context);
      } else if (prif.getString('role')!.contains('manager') ||
          prif.getString('role')!.contains('Manager') ||
          prif.getString('role')!.contains('hr') ||
          prif.getString('role')!.contains('Hr')) {
        EasyLoading.dismiss();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return HomeScreen(
            hr: true,
          );
        }), (route) => false);
      } else if (prif.getString('role')!.contains('Employee') ||
          prif.getString('role')!.contains('employee')) {
        EasyLoading.dismiss();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return HomeScreen(
            hr: false,
          );
        }), (route) => false);
      } else {
        EasyLoading.dismiss();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return HomeScreen(
            hr: true,
          );
        }), (route) => false);
      }
    } else if (response.statusCode == 404) {
      EasyLoading.dismiss();
      // ignore: use_build_context_synchronously
      Ui.getSnackBar(title: 'Please Enter Valid OTP!', context: context);
    }
  }

  // void _listenForCode() async {
  //   SmsAutoFill().listenForCode;
  //   final code = await SmsAutoFill().getAppSignature;
  //   setState(() {
  //     _verificationCode = code;
  //     existuserOtp(_verificationCode!);
  //   });
  // }

  // ignore: unused_field
  Timer? _timer;
  int _start = 30;

  void startTimer() {
    _start = 30;
    // ignore: unnecessary_const
    const oneSec = const Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            setState(() {
              resendOTP = false;
            });
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.pink.shade900,
          title: apBarText(
            'Verify your OTP',
            Colors.white,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Center(
                  child: Text(
                'Please Enter The 4 Digit Code Send To',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
              Center(
                child: Text(
                  '+91 ${widget.number}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              OtpTextField(
                focusedBorderColor: Colors.pink.shade900,
                fillColor: Colors.pink.shade900,
                numberOfFields: 4,
                borderColor: Colors.pink.shade900,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  otpVerifivationCode = verificationCode;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        resendOTP = true;
                      });
                      indexOtp();
                      startTimer();
                    },
                    child: Text(
                      resendOTP ? _start.toString() : 'Resend OTP!',
                      style: TextStyle(
                          color: Colors.pink.shade900,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                    onTap: () {
                      if (otpVerifivationCode.isEmpty) {
                        existuserOtp(_verificationCode!);
                      } else {
                        existuserOtp(otpVerifivationCode);
                      }
                    },
                    child: submitContainer(context, 'Verify')),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Change number!',
                    style: TextStyle(
                      color: Colors.pink.shade900,
                    ),
                  )),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

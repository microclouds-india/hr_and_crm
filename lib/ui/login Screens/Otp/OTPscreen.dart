import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/main.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:hr_and_crm/ui/home/tabs/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../common/widgets/appbarTXT.dart';

class OTPscreen extends StatefulWidget {
  String number;
  OTPscreen({required this.number});

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  String otpVerifivationCode = '';
  String? _verificationCode;
  bool resendOTP = false;
  indexOtp() async {
    var url = Uri.parse('https://cashbes.com/photography/login/index');
    var response = await http.post(url, body: {'phone': widget.number});
    if (response.statusCode == 200) {
      print(response.body);
      _listenForCode();
    } else {
      print(response.statusCode);
    }
  }

  existuserOtp(String otp) async {
    var url = Uri.parse('https://cashbes.com/photography/login/existuser_otp');
    var response =
        await http.post(url, body: {'phone': widget.number, 'otp': otp});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final prif = await SharedPreferences.getInstance();
      prif.setString('token', data['token']);
      print('tokeeeeeeeeeeeeeeeeeeeen${prif.getString('token')}');
      Ui.getSnackBar(title: 'Login Successfully', context: context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }), (route) => false);
    } else {
      Ui.getSnackBar(title: 'Please Enter Valid OPT!', context: context);
    }
  }

  void _listenForCode() async {
     SmsAutoFill().listenForCode;
    final code = await SmsAutoFill().getAppSignature;
    setState(() {
      _verificationCode = code;
      existuserOtp(_verificationCode!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    indexOtp();
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
              SizedBox(
                height: 40,
              ),
              Center(
                  child: Text(
                'Please Enter The 4 Digit Code Send To',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
              Center(
                child: Text(
                  '+91 ${widget.number}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
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
                  print(otpVerifivationCode);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        resendOTP = true;
                        indexOtp();
                        Timer(Duration(seconds: 30), () {
                          setState(() {
                            resendOTP = false;
                          });
                        });
                      });
                    },
                    child: Text(
                      'Resend OTP!',
                      style: TextStyle(
                          color: resendOTP ? Colors.grey : Colors.pink.shade900,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
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
              Spacer(),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Change number!',
                    style: TextStyle(
                      color: Colors.pink.shade900,
                    ),
                  )),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';

import '../../../common/widgets/appbarTXT.dart';
import 'changePassword.dart';

class MailOTPscreen extends StatefulWidget {
  String mail;
  MailOTPscreen({required this.mail});

  @override
  State<MailOTPscreen> createState() => _MailOTPscreenState();
}

class _MailOTPscreenState extends State<MailOTPscreen> {
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
                  widget.mail,
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                }, // end onSubmit
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ChangePassword();
                        })),
                    child: submitContainer(context, 'Verify')),
              ),
              Spacer(),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Change Mail ID!',
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

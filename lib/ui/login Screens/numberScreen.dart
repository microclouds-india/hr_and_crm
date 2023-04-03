import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/ui/login%20Screens/Otp/OTPscreen.dart';
import 'package:hr_and_crm/ui/signup/signupPage.dart';

import '../../common/widgets/bookingFormTextFields.dart';
import '../../common/widgets/submitContainer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController mobileNumberController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
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
                height: 20,
              ),
              Center(
                child: Text(
                  'Please Enter Your mobile number To',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text('Recive a OTP Verification Code',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),

              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             number = false;
              //           });
              //         },
              //         child: Container(
              //           height: 50,
              //           width: 100,
              //           decoration: BoxDecoration(
              //               border: Border.all(color: Colors.grey),
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(20))),
              //           child: Center(
              //             child: Text('Email'),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 20,
              //       ),
              //       Container(
              //         height: 50,
              //         width: 100,
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.grey),
              //             borderRadius: BorderRadius.all(Radius.circular(20))),
              //         child: Center(
              //           child: Text('Phone'),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BookingFormTextFields(
                  keyboardType: TextInputType.phone,
                  controller: mobileNumberController,
                  hint: 'Emter your mobile number!',
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: GestureDetector(
                    onTap: () {
                      if (mobileNumberController.text.isEmpty) {
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return OTPscreen(
                            number: mobileNumberController.text,
                          );
                        }));
                      }
                    },
                    child: submitContainer(context, 'Get OTP')),
              ),
              Spacer(),
              TextButton(
                  onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignupPage();
                      })),
                  child: Text(
                    'Create new account!',
                    style: TextStyle(color: Colors.pink.shade900),
                  )),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

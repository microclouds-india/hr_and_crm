import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/ui/login%20Screens/Otp/OTPscreen.dart';
import 'package:hr_and_crm/ui/signup/signupPage.dart';
import '../../common/ui.dart';
import '../../common/widgets/bookingFormTextFields.dart';
import 'package:http/http.dart' as http;

import '../../common/widgets/submitContainer.dart';

class NumberLogin extends StatefulWidget {
  const NumberLogin({super.key});

  @override
  State<NumberLogin> createState() => _NumberLoginState();
}

final TextEditingController mobileNumberController = TextEditingController();

class _NumberLoginState extends State<NumberLogin> {
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
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Please Enter Your mobile number To',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const Center(
                child: Text('Receive a OTP Verification Code',
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BookingFormTextFields(
                  iconData: Icons.phone,
                  
                  keyboardType: TextInputType.phone,
                  controller: mobileNumberController,
                  hint: 'Enter your mobile number!',
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: GestureDetector(
                    onTap: () async {
                      print(mobileNumberController.text);
                      if (mobileNumberController.text.isEmpty ||
                          mobileNumberController.text.length > 10 ||
                          mobileNumberController.text.length < 10) {
                        Ui.getSnackBar(
                            title: 'Please Enter Mobile Number',
                            context: context);
                      } else {
                        
                        await EasyLoading.show(status: 'Please Wait...');
                        var url = Uri.parse(
                            'https://cashbes.com/attendance/login/home_login');
                        var response = await http.post(url,
                            body: {'phone': mobileNumberController.text});
                            print(response.body);
                        if (response.statusCode == 200) {
                          print(response.body);
                          var json = jsonDecode(response.body);
                          if (json['user'] == 'new user') {
                            await EasyLoading.dismiss();
                           Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return SignupPage(
                              number: json['phone'].toString(),
                            );
                           }));
                          } else {
                            await EasyLoading.dismiss();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return OTPscreen(
                                number: mobileNumberController.text,
                              );
                            }));
                          }
                        } else {
                          await EasyLoading.dismiss();
                          Ui.getSnackBar(
                              title: 'Server Down!', context: context);
                        }
                      }
                    },
                    child: submitContainer(context, 'Get OTP')),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    if (mobileNumberController.text.isEmpty) {
                      Ui.getSnackBar(title: 'Please Enter Your Number', context: context);
                    }else{
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignupPage(
                          number: mobileNumberController.text,
                        );
                      }));
                    }
                  },
                  child: Text(
                    'Create new account!',
                    style: TextStyle(color: Colors.pink.shade900),
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

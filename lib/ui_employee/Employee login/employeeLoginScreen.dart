import 'package:flutter/material.dart';
import 'package:hr_and_crm/ui/login%20Screens/Otp/OTPscreen.dart';
import 'package:hr_and_crm/ui/signup/signupPage.dart';

import '../../common/ui.dart';
import '../../common/widgets/bookingFormTextFields.dart';
import '../../common/widgets/submitContainer.dart';
import 'employeeOTPscreen.dart';

class EmployeeNumberLogin extends StatefulWidget {
  const EmployeeNumberLogin({super.key});

  @override
  State<EmployeeNumberLogin> createState() => _EmployeeNumberLoginState();
}

final TextEditingController employeemobileNumberController = TextEditingController();

class _EmployeeNumberLoginState extends State<EmployeeNumberLogin> {
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BookingFormTextFields(
                  
                  keyboardType: TextInputType.phone,
                  controller: employeemobileNumberController,
                  hint: 'Emter your mobile number!',
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: GestureDetector(
                    onTap: () {
                      if (employeemobileNumberController.text.isEmpty) {
                        Ui.getSnackBar(
                            title: 'Please Enter Mobile Number',
                            context: context);
                      } else {
                        
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EmployeeOTPscreen(number: employeemobileNumberController.text);
                        }));
                      }
                    },
                    child: submitContainer(context, 'Get OTP')),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

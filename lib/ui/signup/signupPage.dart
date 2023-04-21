import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/strings.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/repository/dropDownServices/dropDownServices.notifier.dart';
import 'package:hr_and_crm/repository/login/notifier/login.notifier.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    otpController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final dropDownServiceData = Provider.of<DropDownServiceNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/icons/logo.png",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                Strings().letsGetStarted,
                style: GoogleFonts.openSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().name,
                  controller: nameController,
                  maxLines: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0),
                      child: BookingFormTextFields(
                        hint: Strings().phone,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 20, top: 10),
                      child:
                          Consumer<LoginNotifier>(builder: (context, data, _) {
                        return data.isLoading2
                            ? Center(
                                heightFactor: 1,
                                widthFactor: 1,
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.pink.shade900,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  if (phoneController.text.isNotEmpty) {
                                    try {
                                      await data.registerUser(
                                          phone: phoneController.text);

                                      if (data.loginModel.status == "200") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor:
                                                Colors.pink.shade900,
                                            content: Text(
                                                "OTP send to ${phoneController.text}"),
                                          ),
                                        );
                                      } else if (data.loginModel.status ==
                                          "404") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor:
                                                Colors.pink.shade900,
                                            content:
                                                Text(data.loginModel.response),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor:
                                                Colors.pink.shade900,
                                            content:
                                                Text("Something went wrong!"),
                                          ),
                                        );
                                      }
                                    } catch (_) {
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   SnackBar(
                                      //     behavior: SnackBarBehavior.floating,
                                      //     backgroundColor: Colors.pink.shade900,
                                      //     content:
                                      //         Text("Something went wrong!"),
                                      //   ),
                                      // );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.pink.shade900,
                                        content:
                                            Text("Please fill all the fields"),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.pink.shade900,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: const Center(
                                    child: Text(
                                      'Get OTP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                      }),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: 'Enter OTP',
                  controller: otpController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().address,
                  controller: addressController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().email,
                  controller: emailController,
                  maxLines: 1,
                ),
              ),
              Consumer<DropDownServiceNotifier>(builder: (context, data, _) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  margin: const EdgeInsets.all(10.0),
                  decoration: Ui.getBoxDecoration(),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    value: dropDownServiceData.selectedregistrationJobrole,
                    items: dropDownServiceData.registrationJobrole.map((
                        String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      dropDownServiceData.setRegistrationJobrole(value.toString());
                    },
                  ),
                );
              }),
              Consumer<LoginNotifier>(builder: (context, data, _) {
                return data.isLoading3
                    ? Center(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.pink.shade900,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.isEmpty &&
                              emailController.text.isEmpty &&
                              phoneController.text.isEmpty &&
                              addressController.text.isEmpty &&
                              passwordController.text.isEmpty &&
                              confirmPasswordController.text.isEmpty) {
                            Ui.getSnackBar(
                                title: Strings().pleaseFillAllFields,
                                context: context);
                          } else {
                            if (phoneController.text.isNotEmpty) {
                              try {
                                await data.registerUserwithotp(
                                  phone: phoneController.text,
                                  otp: otpController.text,
                                );

                                if (data.loginModel.status == "200") {
                                  final prif =
                                      await SharedPreferences.getInstance();
                                  prif.setString('token', data.otpModel.token);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomeScreen(
                                      hr: true,
                                    );
                                  }));
                                } else if (data.loginModel.status == "404") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.pink.shade900,
                                      content: Text(data.loginModel.response),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.pink.shade900,
                                      content: Text("Something went wrong!"),
                                    ),
                                  );
                                }
                              } catch (_) {
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(
                                //   SnackBar(
                                //     behavior: SnackBarBehavior.floating,
                                //     backgroundColor: Colors.pink.shade900,
                                //     content:
                                //         Text("Something went wrong!"),
                                //   ),
                                // );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.pink.shade900,
                                  content: Text("Please fill all the fields"),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade900,
                        ),
                        child: Text(
                          Strings().createAccount,
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      );
              }),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings().alreadyHaveAnAccount,
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/loginPage");
                      },
                      child: Text(
                        Strings().loginSignUp,
                        style: GoogleFonts.openSans(
                          color: Colors.pink.shade900,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

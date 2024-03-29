import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
import 'package:hr_and_crm/common/strings.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/ui/addBranches/addBranchesScreen.dart';
import 'package:hr_and_crm/ui/branches/allBranches.dart';
import 'package:hr_and_crm/ui/branches/branches.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:hr_and_crm/ui/login%20Screens/numberScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Forgot password/mailScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Platform.isAndroid) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        } else if (Platform.isIOS) {
          exit(0);
        }
        return Future.value(false);
      },
      child: Scaffold(
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
                  Strings().welcomeBack,
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  Strings().loginToYourExistingAccount,
                  style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BookingFormTextFields(
                    iconData: Icons.email,
                    hint: Strings().email,
                    controller: emailController,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: BookingFormTextFields(
                    iconData: Icons.password,
                    hint: Strings().password,
                    maxLines: 1,
                    controller: passwordController,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ForgotPasswordMail();
                      }));
                    },
                    child: Text(
                      Strings().forgotPassword,
                      style: GoogleFonts.openSans(
                        color: Colors.pink.shade900,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      Ui.getSnackBar(
                          title: Strings().pleaseFillAllFields,
                          context: context);
                    } else {
                      String emailData = emailController.text;
                      String passwordData = passwordController.text;

                      if (emailData != "" && passwordData != "") {
                        // Navigator.of(context).pushNamed("/homePage");
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return HomeScreen(hr: true,);
                            }));
                      } else {
                        Ui.getSnackBar(
                            title: Strings().incorrectEmailOrPassword,
                            context: context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade700,
                  ),
                  child: Text(
                    Strings().login,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  Strings().orConnectUsing,
                  style: GoogleFonts.openSans(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const NumberLogin();
                      })),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade700,
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Center(child: Icon(Icons.phone, size: 20)),
                          const SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Text(
                              'Phone',
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/addBiometric");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade700,
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.g_mobiledata_rounded,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Text(
                              Strings().google,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   Strings().dontHaveAnAccount,
                      //   style: GoogleFonts.openSans(
                      //     color: Colors.black,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.of(context).pushNamed("/signupPage");
                      //   },
                      //   child: Text(
                      //     Strings().signUp,
                      //     style: GoogleFonts.openSans(
                      //       color: Colors.pink.shade900,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

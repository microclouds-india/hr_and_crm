import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/strings.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';

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
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(Strings().letsGetStarted,
                style: GoogleFonts.openSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().name,
                  controller: nameController,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().phone,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().address,
                  controller: addressController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().email,
                  controller: emailController,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().password,
                  controller: passwordController,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
                child: BookingFormTextFields(
                  hint: Strings().confirmPassword,
                  controller: confirmPasswordController,
                  maxLines: 1,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if(nameController.text.isEmpty &&
                      emailController.text.isEmpty &&
                      phoneController.text.isEmpty &&
                      addressController.text.isEmpty &&
                      passwordController.text.isEmpty &&
                      confirmPasswordController.text.isEmpty
                  ){
                    Ui.getSnackBar(title: Strings().pleaseFillAllFields, context: context);
                  }else {
                    Navigator.of(context).pushNamed("/loginPage");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                ),
                child: Text(Strings().createAccount,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings().alreadyHaveAnAccount,
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/loginPage");
                      },
                      child: Text(Strings().loginSignUp,
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/strings.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/ui/Employees/Add%20Employees/addEmployee.dart';
import 'package:hr_and_crm/ui/home/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../repository/register/register_network.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        Ui.getSnackBar(title: 'No Image Selected', context: context);
      }
    });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController jobRoleController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController cityControllerr = TextEditingController();
  final TextEditingController otpController = TextEditingController();

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

  bool otpOn = false;

  String dropdownValue = 'Male';
  List<String> options = ['Male', 'Female', 'Other'];

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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          otpOn = true;
                        });
                        RegisterNetwork().indexOtp(phoneController.text);
                      },
                      child: Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                            color: otpOn
                                ? Color.fromARGB(0, 233, 30, 98)
                                : Colors.pink.shade900,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Center(
                          child: Text(
                            'Get OTP',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: 'Enter OTP',
                  controller: otpController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().dob,
                  controller: dobController,
                  maxLines: 1,
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
                  hint: Strings().city,
                  controller: cityControllerr,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 15,
                ),
                child: DropdownButton<String>(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().jobRole,
                  controller: jobRoleController,
                  maxLines: 1,
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
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().password,
                  controller: passwordController,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
                child: BookingFormTextFields(
                  hint: Strings().confirmPassword,
                  controller: confirmPasswordController,
                  maxLines: 1,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                  child: Text('Upload Image')),
              ElevatedButton(
                onPressed: () async {
                  final prif = await SharedPreferences.getInstance();
                  if (nameController.text.isEmpty &&
                      emailController.text.isEmpty &&
                      phoneController.text.isEmpty &&
                      addressController.text.isEmpty &&
                      passwordController.text.isEmpty &&
                      jobRoleController.text.isEmpty &&
                      confirmPasswordController.text.isEmpty) {
                    Ui.getSnackBar(
                        title: Strings().pleaseFillAllFields, context: context);
                  } else {
                    RegisterNetwork().register(
                        context: context,
                        phone: phoneController.text,
                        name: nameController.text,
                        otp: otpController.text,
                        gender: dropdownValue,
                        email: emailController.text,
                        dob: dobController.text,
                        city: cityControllerr.text,
                        jobrole: jobRoleController.text,
                        photo: _imageFile!.path);
                   
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
              ),
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

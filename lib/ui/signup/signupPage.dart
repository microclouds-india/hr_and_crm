import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/strings.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/ui/Employees/Add%20Employees/addEmployee.dart';
import 'package:intl/intl.dart';
import '../../repository/register/register_network.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  File? _imageFile;
  bool imageView = true;

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    } else {
      Ui.getSnackBar(title: 'Not Date picked!', context: context);
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) {
      Ui.getSnackBar(title: 'Not Image picked!', context: context);
    } else {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  final TextEditingController signupnameController = TextEditingController();
  final TextEditingController signupemailController = TextEditingController();
  final TextEditingController signupphoneController = TextEditingController();
  final TextEditingController signupjobRoleController = TextEditingController();
  final TextEditingController signupdobController = TextEditingController();
  final TextEditingController signupotpController = TextEditingController();
  final TextEditingController signupCityController = TextEditingController();
   final TextEditingController signUpAddressController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    emailController.clear();
    signupphoneController.clear();
    addressController.clear();

    super.dispose();
  }

  bool otpOn = false;

  String dropdownValue = 'male';
  List<String> options = ['male', 'female', 'other'];
  String jobRole = 'employee';
  List<String> jobroleOptions = ['employee', 'hr', 'manager'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText(
          'Register New account',
          Colors.white,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
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
                  controller: signupnameController,
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
                        controller: signupphoneController,
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
                        if (signupphoneController.text.isEmpty ||
                            signupphoneController.text == null ||
                            signupphoneController.text.length < 10 ||
                            signupphoneController.text.length > 10) {
                          Ui.getSnackBar(
                              title: 'Please enter your phone number!',
                              context: context);
                        } else {
                          setState(() {
                            otpOn = true;
                          });
                          RegisterNetwork()
                              .indexOtp(signupphoneController.text, context);
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.pink.shade900,
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
                  keyboardType: TextInputType.phone,
                  hint: 'Enter OTP',
                  controller: signupotpController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _selectedDate == null
                              ? 'Date of Birth'
                              : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Icon(Icons.calendar_today)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().email,
                  controller: signupemailController,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  hint: Strings().city,
                  controller: signupCityController,
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
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 15,
                ),
                child: DropdownButton<String>(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  isExpanded: true,
                  value: jobRole,
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? newValue) {
                    setState(() {
                      jobRole = newValue!;
                    });
                  },
                  items: jobroleOptions
                      .map<DropdownMenuItem<String>>((String value) {
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
                  hint: 'Address',
                  controller: signUpAddressController,
                  maxLines: 1,
                ),
              ),
              _imageFile == null
                  ? SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.file(
                        File(_imageFile!.path),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),

              ElevatedButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: const Text('Upload Image')),

              ElevatedButton(
                onPressed: () async {
                  if (signupnameController.text.isEmpty &&
                      signupemailController.text.isEmpty &&
                      signupphoneController.text.isEmpty &&
                      signUpAddressController.text.isEmpty&&
                      signupjobRoleController.text.isEmpty) {
                    // ignore: use_build_context_synchronously
                    Ui.getSnackBar(
                        title: Strings().pleaseFillAllFields, context: context);
                  } else {
                    // ignore: use_build_context_synchronously
                    // RegisterNetwork().register(
                    //     context: context,
                    //     phone: signupphoneController.text,
                    //     name: signupnameController.text,
                    //     otp: signupotpController.text,
                    //     gender: dropdownValue,
                    //     email: signupemailController.text,
                    //     dob: DateFormat('dd/MM/yyyy').format(_selectedDate!),
                    //     city: signupCityController.text,
                    //     jobrole: signupjobRoleController.text,
                    //     photo: _imageFile.path);
                    print(signupphoneController.text);
                    print(signupnameController.text);
                    print(signupotpController.text);
                    print(signupemailController.text);
                    print(signupCityController.text);

                    final client = http.Client();
                    try {
                      final request = await client.post(
                          Uri.parse(
                              'https://cashbes.com/attendance/login/register'),
                          body: {
                            "phone": signupphoneController.text,
                            "name": signupnameController.text,
                            "otp": signupotpController.text,
                            "gender": dropdownValue,
                            "email": signupemailController.text,
                            "dob":
                                DateFormat('dd-MM-yyyy').format(_selectedDate!),
                            "city": signupCityController.text,
                            "jobrole": jobRole,
                            "photo": _imageFile!.path,
                            'address': signUpAddressController.text
                          });
                      if (request.statusCode == 200) {
                        var json = jsonDecode(request.body);
                        Ui.getSnackBar(
                            title: json['response'], context: context);
                        print(request.body);
                      } else {
                        var json = jsonDecode(request.body);
                        Ui.getSnackBar(
                            title: json['response'], context: context);
                      }
                    } catch (e) {
                      print(e);
                      Ui.getSnackBar(title: "Network Issue!", context: context);
                      throw Exception(e);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

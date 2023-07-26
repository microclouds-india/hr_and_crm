import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/strings.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/ui/Employees/Add%20Employees/addEmployee.dart';
import 'package:hr_and_crm/ui/login%20Screens/numberScreen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../repository/register/register_network.dart';

class SignupPage extends StatefulWidget {
  String number;
  SignupPage({required this.number});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late Future<List<Company>> futureCompanies;
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
  signUpSelectDateController.text = DateFormat('dd/MM/yyyy')
      .format(picked)
      .toString();
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
    final TextEditingController signUpSelectDateController = TextEditingController();


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
  var onChangedCompany = '';
  var onChangedId = '';

  String dropdownValue = 'male';
  List<String> options = ['male', 'female', 'other'];
  String jobRole = 'employee';
  List<String> jobroleOptions = ['employee', 'hr', 'manager'];

  Future<List<Company>> fetchCompanies() async {
    final response = await http
        .get(Uri.parse('https://cashbes.com/attendance/apis/companies'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final companiesData = data['data'] as List<dynamic>;
      final companies =
          companiesData.map((company) => Company.fromJson(company)).toList();
      return companies;
    } else {
      throw Exception('Failed to fetch companies');
    }
  }

  @override
  void initState() {
    super.initState();
    signupphoneController.text = widget.number;
    futureCompanies = fetchCompanies();
  }

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
                'Create Your Account',
                style: GoogleFonts.openSans(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text('Please enter info to create account',
                  style: GoogleFonts.openSans(
                    fontSize: 15,
                    color: Colors.black,
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: BookingFormTextFields(
                  iconData: Icons.person,
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
                        iconData: Icons.phone,
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
                              title: 'Please enter your valid phone number!',
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
                  iconData: Icons.password,
                  keyboardType: TextInputType.phone,
                  hint: 'Enter OTP',
                  controller: signupotpController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only( left: 20.0, right: 20.0, top: 10.0),
                child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: BookingFormTextFields(
                        iconData: Icons.calendar_month,
                        controller: signUpSelectDateController,
                          labelView: false,
                          hint: _selectedDate == null
                              ? 'Date of birth'
                              : DateFormat('dd/MM/yyyy')
                                  .format(_selectedDate!)
                                  .toString()),
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.only( left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  iconData: Icons.email,
                  hint: Strings().email,
                  controller: signupemailController,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only( left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  iconData: Icons.location_city,
                  hint: Strings().city,
                  controller: signupCityController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 20.0, right: 20.0, top: 10.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  // margin: const EdgeInsets.all(6),
                  // decoration: Ui.getBoxDecorationWithoutBorder(),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  width: double.infinity,
                  child: DropdownButton<String>(
                  underline: SizedBox(),
                    hint: const Text(
                      "Select for gender",
                      style: TextStyle(color: Colors.black),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    isExpanded: true,
                    value: dropdownValue,
                    // icon: const Icon(Icons.arrow_downward,size: 20,weight: 20,),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300
                        ),),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 20.0, right: 20.0, top: 10.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  // margin: const EdgeInsets.all(6),
                  // decoration: Ui.getBoxDecorationWithoutBorder(),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      hint: const Text(
                        "Select for Job role",
                        style: TextStyle(color: Colors.grey),
                      ),
                      isExpanded: true,
                      value: jobRole,
                      // icon: const Icon(Icons.arrow_downward,size: 20,weight: 20,),
                      onChanged: (String? newValue) {
                        setState(() {
                          jobRole = newValue!;
                        });
                      },
                      items: jobroleOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                          style: TextStyle(
                            fontSize: 15,
                          fontWeight: FontWeight.w300
                          ),),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<Company>>(
                future: futureCompanies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final companies = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.only( left: 20.0, right: 20.0, top: 10.0),
                      child: Container(
                        
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        // margin: const EdgeInsets.all(6),
                        // decoration: Ui.getBoxDecorationWithoutBorder(),
                        decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: DropdownButton<String>(
                            
                            isExpanded: true,
                            // icon: const Icon(Icons.arrow_downward,size: 20,weight: 20,),
                            underline: const SizedBox(),
                            value: onChangedCompany.isNotEmpty
                                ? onChangedCompany
                                : null,
                            hint: const Text('Select Company'),
                            onChanged: (newValue) {
                              setState(() {
                                onChangedCompany = newValue!;
                              });
                              // Find the selected company object based on the selected value
                              Company selectedCompany = companies.firstWhere(
                                (company) =>
                                    company.companyName == onChangedCompany,
                                orElse: () => Company(
                                    id: '',
                                    companyName: '',
                                    tdate: '',
                                    ttime: ''),
                              );
                              // Print the selected company's id
                              onChangedId = selectedCompany.id;
                              print(selectedCompany.id);
                            },
                            items: companies.map((company) {
                              return DropdownMenuItem<String>(
                                value: company.companyName,
                                child: Text(company.companyName,style: TextStyle(
                                 fontSize: 15,
                          fontWeight: FontWeight.w300
                                ),),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Companies not available');
                  }

                  return CircularProgressIndicator();
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only( left: 20.0, right: 20.0, top: 10.0),
                child: BookingFormTextFields(
                  iconData: Icons.location_city,
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
                      signUpAddressController.text.isEmpty &&
                      signupjobRoleController.text.isEmpty &&
                      onChangedCompany.isEmpty) {
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
                    print(DateFormat('dd-MM-yyyy').format(_selectedDate!));
                    print(onChangedId);
                    EasyLoading.show(status: 'Please Wait...');
                    try {
                      var headers = {
                        'Cookie':
                            'ci_session=d2c186b54327b04b7fcf00c356bc49ab7486a35a'
                      };
                      var request = http.MultipartRequest(
                          'POST',
                          Uri.parse(
                              'https://cashbes.com/attendance/login/register'));
                      request.fields.addAll({
                        'phone': signupphoneController.text,
                        'name': signupnameController.text,
                        'otp': signupotpController.text,
                        'gender': dropdownValue,
                        'email': signupemailController.text,
                        'dob': DateFormat('dd-MM-yyyy').format(_selectedDate!),
                        'city': signupCityController.text,
                        'jobrole': jobRole,
                        'address': signUpAddressController.text,
                        'company_id': onChangedId,
                        'branch_id': '1'
                      });
                      request.files.add(await http.MultipartFile.fromPath(
                          'photo', _imageFile!.path));
                      request.headers.addAll(headers);

                      http.StreamedResponse response = await request.send();

                      if (response.statusCode == 200) {
                        print(await response.stream.bytesToString());
                        EasyLoading.dismiss();
                        Ui.getSnackBar(
                            title: 'New Account Created', context: context);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return NumberLogin();
                        }));
                      } else {
                        print(response.reasonPhrase);
                        EasyLoading.dismiss();
                        Ui.getSnackBar(
                            title: 'Account ceation faild!', context: context);
                      }
                    } catch (e) {
                      EasyLoading.dismiss();
                      Ui.getSnackBar(title: 'Server Error', context: context);
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

class Company {
  final String id;
  final String companyName;
  final String tdate;
  final String ttime;

  Company({
    required this.id,
    required this.companyName,
    required this.tdate,
    required this.ttime,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyName: json['company_name'],
      tdate: json['tdate'],
      ttime: json['ttime'],
    );
  }
}

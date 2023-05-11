import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:intl/intl.dart';
import '../../../common/ui.dart';
import 'package:http/http.dart' as http;
import '../../../common/widgets/appbarTXT.dart';
import '../../../common/widgets/submitContainer.dart';
import '../employees.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

TextEditingController nameController = TextEditingController();
TextEditingController mobileNumberController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController addressController = TextEditingController();

addNewEmployee(
    DateTime _selecteddate, String gender, BuildContext context) async {
  EasyLoading.show(status: 'loading...');
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  var uri = Uri.parse('https://cashbes.com/attendance/apis/add_employee');
  var response = await http.post(uri, body: {
    'name': nameController.text,
    'dob': formatter.format(_selecteddate),
    'email': emailController.text,
    'city': cityController.text,
    'gender': gender,
    'address': addressController.text,
    'phone': mobileNumberController.text,
    
  });
  if (response.statusCode == 200) {
    Ui.getSnackBar(title: 'New Employye Added', context: context);
    EasyLoading.dismiss();
  } else {
    Ui.getSnackBar(title: 'Server Busy', context: context);
    EasyLoading.dismiss();
  }
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String dropdownValue = 'Male';
  List<String> options = ['Male', 'Female', 'Other'];

  File? _imageFile;

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

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('yyyy-MM-dd');
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return EmployeesScreen();
        }));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return EmployeesScreen();
                }));
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.pink.shade900,
          title: apBarText('Add Employee', Colors.white),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: _imageFile == null
                              ? Image.asset(
                                  'assets/icons/logo.png',
                                  height: 100.0,
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _imageFile!,
                                  height: 100.0,
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 69),
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        )
                      ],
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: BookingFormTextFields(
                          hint: 'Date of Birth',
                          controller: TextEditingController(
                            text: _selectedDate != null
                                ? format.format(_selectedDate!)
                                : '',
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 0.2,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BookingFormTextFields(
                    controller: nameController,
                    keyboardType: TextInputType.multiline,
                    hint: 'Full name',
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BookingFormTextFields(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    hint: 'Mobile Number',
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BookingFormTextFields(
                    controller: addressController,
                    keyboardType: TextInputType.multiline,
                    hint: 'Address',
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BookingFormTextFields(
                    hint: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                  ),
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Padding(
                //         padding: const EdgeInsets.only(top: 20),
                //         child: TextFormField(
                //           keyboardType: TextInputType.number,
                //           decoration: const InputDecoration(
                //               hintText: 'Salary',
                //               isDense: true,
                //               border: OutlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.black))),
                //           maxLines: 1,
                //           minLines: 1,
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //         child: GestureDetector(
                //             onTap: () {}, child: salaryContainer(txt: 'Yearly'))),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 15, bottom: 8.0),
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
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BookingFormTextFields(
                    hint: 'Reference (optional)',
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      if (nameController.text == '' &&
                          mobileNumberController.text == '' &&
                          addressController.text == '' &&
                          emailController.text == '' &&
                          dropdownValue == '') {
                        Ui.getSnackBar(
                            title: 'Please Enter Valid Details',
                            context: context);
                      } else {
                        addNewEmployee(_selectedDate!, dropdownValue, context);
                      }
                    },
                    child: submitContainer(context, 'SUBMIT'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget salaryContainer({required String txt}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 10),
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.pink.shade900,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Text(
          txt,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/ui.dart';
import '../../../common/widgets/addProfilePic.dart';
import 'package:http/http.dart' as http;
import '../../../common/widgets/appbarTXT.dart';
import '../../../common/widgets/submitContainer.dart';

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
  } else {
    Ui.getSnackBar(title: 'Server Busy', context: context);
  }
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  late DateTime _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  String dropdownValue = 'Male';
  List<String> options = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(_selectedDate);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                      child: addProfilePic(imageUrl: 'assets/icons/logo.png')),
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    _selectedDate == DateTime.now
                                        ? Text('Date Of Birth')
                                        : Text(formattedDate),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              hintText: 'Employee ID',
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                          maxLines: 1,
                          minLines: 1,
                        ),
                      ],
                    ),
                  )
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
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Full Name',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: mobileNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Mobile Number',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Address',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Salary',
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {}, child: salaryContainer(txt: 'Yearly'))),
                ],
              ),
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
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Reference (optional)',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  maxLines: 1,
                  minLines: 1,
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
                      addNewEmployee(_selectedDate, dropdownValue, context);
                    }
                  },
                  child: submitContainer(context, 'SUBMIT'))
            ],
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

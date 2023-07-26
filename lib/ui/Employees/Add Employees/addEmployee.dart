import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

addNewEmployee(DateTime _selecteddate, String gender, BuildContext context,
    String jobrole, String imagefile, String branchId) async {
  EasyLoading.show(status: 'Please Wait...');
  final prif = await SharedPreferences.getInstance();
  var headers = {
    'Cookie': 'ci_session=c621b96204e19f7c2aa719489287fe7a21de042d'
  };
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://cashbes.com/attendance/apis/add_employee'));
  request.fields.addAll({
    'name': nameController.text,
    'dob': DateFormat('dd/MM/yyyy').format(_selecteddate),
    'email': emailController.text,
    'city': cityController.text,
    'gender': gender,
    'address': addressController.text,
    'phone': mobileNumberController.text,
    'job_role': jobrole,
    'branch_id': branchId,
    'company_id': prif.getString('MyCompanyId').toString(),
    'token':prif.getString('token').toString()
  });
  request.files.add(await http.MultipartFile.fromPath('photo', imagefile));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    Ui.getSnackBar(title: 'New employee added', context: context);
    EasyLoading.dismiss();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return EmployeesScreen();
    }));
  } else {
    print(response.reasonPhrase);
    Ui.getSnackBar(title: 'Faild!', context: context);
    EasyLoading.dismiss();
  }
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  String selectedBranchId = "";
  String selectedBranchName = "";

  Future<List<Branch>> fetchBranches() async {
    final prif = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('https://cashbes.com/attendance/apis/branches'),
      body: {'token': prif.getString('token').toString()},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final branchesData = jsonData['data'] as List<dynamic>;
      List<Branch> branches = branchesData.map((data) {
        return Branch(
            id: data['id'].toString(), branchName: data['branch_name']);
      }).toList();
      return branches;
    } else {
      throw Exception('Failed to fetch branches');
    }
  }

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

  String jobrole = 'employee';
  List<String> jobroleValues = ['employee', 'hr', 'manager'];

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
                          iconData: Icons.calendar_month,
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
                    iconData: Icons.person,
                    controller: nameController,
                    keyboardType: TextInputType.multiline,
                    hint: 'Full name',
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BookingFormTextFields(
                    iconData: Icons.phone,
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    hint: 'Mobile Number',
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BookingFormTextFields(
                    iconData: Icons.location_on,
                    controller: addressController,
                    keyboardType: TextInputType.multiline,
                    hint: 'Address',
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: BookingFormTextFields(
                    iconData: Icons.email,
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
                  padding: const EdgeInsets.only(top: 10, bottom: 10
                      // left: 8.0,
                      // right: 8.0,
                      ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    width: double.infinity,
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    width: double.infinity,
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      isExpanded: true,
                      value: jobrole,
                      icon: const Icon(Icons.arrow_downward),
                      onChanged: (String? newValue) {
                        setState(() {
                          jobrole = newValue!;
                        });
                      },
                      items: jobroleValues
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: BookingFormTextFields(
                //     hint: 'Reference (optional)',
                //     keyboardType: TextInputType.multiline,
                //     maxLines: 1,
                //   ),
                // ),

                FutureBuilder<List<Branch>>(
                  future: fetchBranches(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Branch> branches = snapshot.data!;
                      Branch? selectedBranch;

                      if (branches.isNotEmpty) {
                        if (selectedBranchId != null) {
                          // Find the branch with the selectedBranchId
                          selectedBranch = branches.firstWhere(
                            (branch) => branch.id == selectedBranchId,
                            orElse: () => branches[0],
                          );
                        } else {
                          selectedBranch = branches[0];
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          width: double.infinity,
                          child: DropdownButtonFormField<Branch>(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            icon: const Icon(Icons.arrow_downward),
                            isExpanded: true,
                            value: selectedBranch,
                            items: branches.map((branch) {
                              return DropdownMenuItem<Branch>(
                                value: branch,
                                child: Text(branch.branchName),
                              );
                            }).toList(),
                            onChanged: (selectedBranch) {
                              setState(() {
                                selectedBranchId = selectedBranch!.id;
                                selectedBranchName = selectedBranch.branchName;
                              });
                              print("Selected Branch ID: $selectedBranchId");
                              print(
                                  "Selected Branch Name: $selectedBranchName");
                            },
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),

                GestureDetector(
                    onTap: () {
                      if (nameController.text == '' &&
                          mobileNumberController.text == '' &&
                          addressController.text == '' &&
                          emailController.text == '' &&
                          dropdownValue == '' &&
                          _imageFile == null &&
                          selectedBranchId.isEmpty) {
                        Ui.getSnackBar(
                            title: 'Please Enter Valid Details',
                            context: context);
                      } else {
                        addNewEmployee(_selectedDate!, dropdownValue, context,
                            jobrole, _imageFile!.path, selectedBranchId);
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

class Branch {
  final String id;
  final String branchName;

  Branch({required this.id, required this.branchName});
}

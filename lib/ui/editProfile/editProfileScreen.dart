import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:hr_and_crm/ui/Employees/Add%20Employees/addEmployee.dart';
import 'package:hr_and_crm/ui/Settings/settingsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  String name;
  String email;
  String phone;
  String address;
  String dob;
  String city;
  String gender;
  String imageUrl;
  EditProfileScreen(
      {required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.city,
      required this.dob,
      required this.gender,
      required this.imageUrl});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController OTPController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String _imagepath = '';
  final ImagePicker imgpicker = ImagePicker();
  Future getImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagepath = pickedFile.path;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking image.");
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullnameController.text = widget.name;
    emailController.text = widget.email;
    mobileNumberController.text = widget.phone;
    addressController.text = widget.address;
    _selectedDate = DateFormat("dd-mm-yyyy").parse(widget.dob);
    cityController.text = widget.city;
    genderController.text = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    updateProfile(
        String dateofbirth, String gender, String dropdownValue) async {
      EasyLoading.show(status: 'Please Wait...');
      final prif = await SharedPreferences.getInstance();
      var headers = {
        'Cookie': 'ci_session=20042503ba20b92bc2b51bf10bb6c86f3f483946'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://cashbes.com/attendance/apis/edit_profile'));
      request.fields.addAll({
        'token': prif.getString('token').toString(),
        'name': fullnameController.text,
        'dob': dateofbirth,
        'email': emailController.text,
        'city': cityController.text,
        'gender': dropdownValue,
        'address': addressController.text
      });
      request.files.add(await http.MultipartFile.fromPath('photo', _imagepath));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        EasyLoading.dismiss();
        Ui.getSnackBar(title: 'Profile Updated', context: context);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return SettingsScreen();
        }));
      } else {
        print(response.reasonPhrase);
        EasyLoading.dismiss();
        Ui.getSnackBar(title: 'Profile Edit Fail!', context: context);
      }
    }

    final format = DateFormat('dd-mm-yyyy');
    String dropdownValue = 'Male';
    List<String> options = ['Male', 'Female', 'Other'];
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return SettingsScreen();
        }));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return SettingsScreen();
                }));
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.pink.shade900,
          title: apBarText('Edit your profile', Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _imagepath.isEmpty
                          ? GestureDetector(
                              onTap: () => getImage(),
                              child: Image.network(
                                widget.imageUrl,
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.cover,
                              ),
                            )
                          : GestureDetector(
                              onTap: () => getImage(),
                              child: Image.file(
                                File(_imagepath),
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 69),
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
                    )
                  ],
                )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: BookingFormTextFields(
                    iconData: Icons.person,
                    controller: fullnameController,
                    hint: 'Name',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: BookingFormTextFields(
                    iconData: Icons.location_city,
                    hint: 'Address',
                    controller: addressController,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: BookingFormTextFields(
                //           controller: mobileNumberController,
                //          hint: 'Mobile number',
                //         ),
                //       ),
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             height: 50,
                //             width: 50,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.all(Radius.circular(10)),
                //               color: Colors.pink.shade900,
                //             ),
                //             child: Center(
                //               child: Text(
                //                 'Get OTP',
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.white),
                //               ),
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: TextFormField(
                //     controller: OTPController,
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(), hintText: 'Enter your OTP'),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: BookingFormTextFields(
                    iconData: Icons.email,
                    controller: emailController,
                    hint: 'Email',
                  ),
                ),

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
                  padding: const EdgeInsets.only(top: 10),
                  child: BookingFormTextFields(
                    iconData: Icons.location_city,
                    hint: 'City',
                    controller: cityController,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      updateProfile(format.format(_selectedDate!),
                          dropdownValue, dropdownValue);
                    },
                    child: submitContainer(context, 'Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

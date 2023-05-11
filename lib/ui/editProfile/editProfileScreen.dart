import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/common/widgets/bookingFormTextFields.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  String name;
  String email;
  String phone;
  EditProfileScreen(
      {required this.name, required this.email, required this.phone});

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullnameController.text = widget.name;
    emailController.text = widget.email;
    mobileNumberController.text = widget.phone;
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
  Widget build(BuildContext context) {
    updateProfile(String dateofbirth, String gender) async {
      final prif = await SharedPreferences.getInstance();
      var url = Uri.parse('https://cashbes.com/attendance/apis/edit_profile');
      var response = await http.post(url, body: {
        'token': prif.getString('token'),
        'name': fullnameController.text,
        'dob': dateofbirth,
        'email': emailController.text,
        'city': cityController.text,
        'gender': gender,
        'address': addressController.text
      });
      if (response.statusCode == 200) {
        print(response.body);
        Ui.getSnackBar(title: 'Profile Updated', context: context);
      } else {
        Ui.getSnackBar(title: 'Server Busy!', context: context);
      }
    }

    String dropdownValue = 'Male';
    List<String> options = ['Male', 'Female', 'Other'];

    final format = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
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
                    child: Image.asset(
                      'assets/icons/man.png',
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
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
                  controller: fullnameController,
                  hint: 'Name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: BookingFormTextFields(
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
              GestureDetector(
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: BookingFormTextFields(
                  controller: emailController,
                  hint: 'Email',
                ),
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
                padding: const EdgeInsets.only(top: 10),
                child: BookingFormTextFields(
                  hint: 'City',
                  controller: cityController,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (fullnameController.text == '' ||
                        addressController.text == '' ||
                        _selectedDate == null ||
                        emailController.text == '' ||
                        cityController.text == '' ||
                        dropdownValue == '') {
                      Ui.getSnackBar(
                          title: 'Please enter your detail', context: context);
                    } else {
                      print(format.format(_selectedDate!));
                      updateProfile(
                          format.format(_selectedDate!), dropdownValue);
                    }
                  },
                  child: submitContainer(context, 'Save'))
            ],
          ),
        ),
      ),
    );
  }
}

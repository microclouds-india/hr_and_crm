import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart' as http;
import 'package:hr_and_crm/common/widgets/addProfilePic.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:hr_and_crm/common/widgets/submitContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  String name;
  String email;
  String phone;
  EditProfileScreen(
      {required this.name,
     
      required this.email,
      required this.phone});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    updateProfile() async {
      final prif = await SharedPreferences.getInstance();
      var url = Uri.parse('https://cashbes.com/attendance/apis/edit_profile');
      var response = await http.post(url, body: {
        'token': prif.getString('token'),
        'name': fullnameController.text,
        'dob': dobController.text,
        'email': emailController.text,
        'city': cityController.text,
        'gender': genderController.text,
        'address': addressController.text
      });
      if (response.statusCode == 200) {
        print(response.body);
        Ui.getSnackBar(title: 'Profile Updated', context: context);
      } else {
        Ui.getSnackBar(title: 'Server Busy!', context: context);
      }
    }

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
              Center(child: addProfilePic(imageUrl: 'assets/icons/man.png')),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: fullnameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: mobileNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.pink.shade900,
                          ),
                          child: Center(
                            child: Text(
                              'Get OTP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: OTPController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter your OTP'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: dobController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Date of Birth'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'City'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: genderController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Gender'),
                ),
              ),
              GestureDetector(
                  onTap: updateProfile, child: submitContainer(context, 'Save'))
            ],
          ),
        ),
      ),
    );
  }
}

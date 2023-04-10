import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_and_crm/common/widgets/appbarTXT.dart';
import 'package:http/http.dart' as http;
import '../../common/strings.dart';
import '../../common/widgets/bookingFormTextFields.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _AddAccountState extends State<AddAccount> {
  logiDate() async {
    var url = Uri.parse('https://cashbes.com/attendance/apis/multi_login');
    var response = await http.post(url, body: {
      'username': usernameController.text,
      'password': passwordController.text,
    });
    if (response.statusCode==200) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: apBarText('Login New Account', Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BookingFormTextFields(
                controller: usernameController,
                hint: 'Username',
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: BookingFormTextFields(
                controller: passwordController,
                hint: Strings().password,
                maxLines: 1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: logiDate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade700,
              ),
              child: Text(
                Strings().login,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

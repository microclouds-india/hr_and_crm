import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/Add%20account/addAccount.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../common/widgets/bookingFormTextFields.dart';

class Multilogin extends StatefulWidget {
  @override
  _MultiloginState createState() => _MultiloginState();
}

class _MultiloginState extends State<Multilogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = "";

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.https('cashbes.com', '/attendance/apis/multi_login'),
      body: {
        'username': _usernameController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      Ui.getSnackBar(title: 'Login Successfully', context: context);
    } else {
      Ui.getSnackBar(title: 'Login Faild', context: context);
      final Map<String, dynamic> errorData = json.decode(response.body);
      setState(() {
        _errorMessage = errorData['message'];
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    height: 100,
                    width: 100,
                    image: AssetImage('assets/icons/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BookingFormTextFields(
                    hint: 'Username',
                    controller: usernameController,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 20),
                  child: BookingFormTextFields(
                    hint: 'Password',
                    controller: passwordController,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 16.0),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade900),
                    onPressed: () {
                      if (usernameController.text.isEmpty &&
                          passwordController.text.isEmpty) {
                        Ui.getSnackBar(
                            title: "Please Enter a Value", context: context);
                      } else {
                        _login();
                      }
                    },
                    child: const Text('Login'),
                  ),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

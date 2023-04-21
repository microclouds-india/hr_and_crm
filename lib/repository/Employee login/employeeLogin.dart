import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/ui.dart';
import '../../ui/home/homeScreen.dart';

class EmployeeLoginNetWork {
  getOTP(String number) async {
    var url = Uri.parse('https://cashbes.com/photography/login/index');
    var response = await http.post(url, body: {'phone': number});
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }

  existuserOtp(String otp, BuildContext context, String number) async {
    var url = Uri.parse('https://cashbes.com/photography/login/existuser_otp');
    var response = await http.post(url, body: {'phone': number, 'otp': otp});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final prif = await SharedPreferences.getInstance();
      prif.setString('token', data['token']);
      print('newTikeeeeeeeen${data['token']}');
      prif.setBool('HR', false);
      print('tokeeeeeeeeeeeeeeeeeeeen${prif.getString('token')}');
      Ui.getSnackBar(title: 'Login Successfully', context: context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return HomeScreen(
          hr: false,
        );
      }), (route) => false);
    } else {
      Ui.getSnackBar(title: 'Please Enter Valid OPT!', context: context);
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../common/ui.dart';
import '../../ui/home/homeScreen.dart';

class RegisterNetwork {
  register(
      {required String phone,
      required BuildContext context,
      required String name,
      required String otp,
      required String gender,
      required String email,
      required String dob,
      required String city,
      required String jobrole,
      required String photo}) async {
    var headers = {
      'Cookie': 'ci_session=e56e429efc33b0d6f1d1341d71db33db74d39d69'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://cashbes.com/attendance/login/register'));
    request.fields.addAll({
      'phone': phone,
      'name': name,
      'otp': otp,
      'gender': gender,
      'email': email,
      'dob': dob,
      'city': city,
      'jobrole': jobrole
    });
    request.files.add(await http.MultipartFile.fromPath('photo', photo));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Ui.getSnackBar(title: 'Registration Completed', context: context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return HomeScreen(hr: true);
      }), (route) => false);
    } else {
      print(response.stream.bytesToString());
      Ui.getSnackBar(title: 'Registration Faild', context: context);
    }
  }

  indexOtp(String number) async {
    var url = Uri.parse('https://cashbes.com/photography/login/index');
    var response = await http.post(url, body: {'phone': number});
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }
}

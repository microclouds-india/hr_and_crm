import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../common/ui.dart';
import '../../ui/home/homeScreen.dart';

class RegisterNetwork {
  // register(
  //     {required String phone,
  //     required BuildContext context,
  //     required String name,
  //     required String otp,
  //     required String gender,
  //     required String email,
  //     required String dob,
  //     required String city,
  //     required String jobrole,
  //     required String photo}) async {
  //     final client = http.Client();
  //    try {
  //     final request = await client.post(Uri.parse('https://cashbes.com/attendance/login/register'), body: {
  //       "phone": phone,
  //       "name": name,
  //       "otp": otp,
  //       "gender": gender,
  //       "email": email,
  //       "dob":'10/12/1990',
  //       "city":city,
  //       "jobrole":jobrole,
  //     }).timeout(const Duration(seconds: 10));

  //     if (request.statusCode == 200) {
  //       print(request.body);
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception(e);
  //   }
  // }

  indexOtp(String number, BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse('https://cashbes.com/attendance/login/index');
    var response = await http.post(url, body: {'phone': number});
    if (response.statusCode == 200) {
      print(response.body);
      EasyLoading.dismiss();
      Ui.getSnackBar(title: 'OTP Recived', context: context);
    } else {
      EasyLoading.dismiss();
      print('rrrrrrrrrr${response.statusCode}');
    }
  }
}

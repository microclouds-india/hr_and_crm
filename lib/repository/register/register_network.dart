import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    await EasyLoading.show(
      status: 'Please Wait...',
      maskType: EasyLoadingMaskType.black,
    );
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
      await EasyLoading.dismiss();
      print(
          'Successsssssssssssssssssssssssssssssssssssss${response.stream.bytesToString()}');
      // ignore: use_build_context_synchronously
      Ui.getSnackBar(title: 'Registration Completed', context: context);
      Navigator.pop(context);
    } else if (response.statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.pink.shade900,
          content: Text("File not found"),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      Ui.getSnackBar(title: 'Something went wrong!', context: context);
      print(
          'failllllllllllllllllllllllllllllllllllllll${response.stream.bytesToString()}');
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

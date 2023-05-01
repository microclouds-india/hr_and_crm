import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ui/login Screens/numberScreen.dart';

class LogOutNewtworking {
  String endPoint = 'https://cashbes.com/attendance/login/logout';
  logout(String token, BuildContext context) async {
    final prif = await SharedPreferences.getInstance();
    var url = Uri.parse(endPoint);
    var response = await http.post(url, body: {
      'token': token,
    });
    if (response.statusCode == 200) {
      await prif.remove('token');
      await prif.remove('role');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return NumberLogin();
      }), (route) => false);
    } else {
      Ui.getSnackBar(title: 'Server Error!', context: context);
    }
  }
}

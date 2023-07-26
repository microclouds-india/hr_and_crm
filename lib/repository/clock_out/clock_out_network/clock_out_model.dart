import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/clock_out/model/clock_OUT_model.dart';
import 'package:http/http.dart' as http;

class ClockOUTNetwork {
  String endpoint = 'https://cashbes.com/attendance/apis/clock_out';
  late ClockOutModel clockOutModel;

  clockOUT(
      {
        required String clockin,
        required String token,
      required String id,
      required String clockOutime,
      required BuildContext context,
      required String attendDate}) async {
    try {
      EasyLoading.show(status: 'Please Wait...');
      var url = Uri.parse(endpoint);
      var response = await http.post(url, body: {
        'token': token,
        'id': id,
        'clock_out': clockOutime,
        'attend_date': attendDate,
        'clock_in': clockin,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('Clock out');
        print(response.body);
        EasyLoading.dismiss();
        Ui.getSnackBar(title: 'Attendance Closed', context: context);
      }
    } catch (e) {
      EasyLoading.dismiss();
      return Future.error(e);
    }
  }
}

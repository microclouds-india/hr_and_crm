import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/clock_in/model/clock_in_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClockINNetWork {
  String endpoint = 'https://cashbes.com/attendance/apis/clock_in';

  Future<ClockInModel?> clockINnetwork(
      String date, String time, String token, BuildContext context) async {
    final prif = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(endpoint);
      var response = await http.post(url,
          body: {'token': token, 'attend_date': date, 'clock_in': time});
      if (response.statusCode == 200) {
        await EasyLoading.show(
                  status: 'loading...',
                  maskType: EasyLoadingMaskType.black,
                );
        print(response.body);
        final json = jsonDecode(response.body);
        await prif.setString('emploee_id', json['id']);
        await prif.setString('clockin_time', json['clock_in']);
        EasyLoading.dismiss();
        Ui.getSnackBar(title: 'Attendance Marked', context: context);
        print('ppppppppp');
      } else {
        await EasyLoading.dismiss();
        Ui.getSnackBar(title: 'Not Attendance!', context: context);
      }
      await EasyLoading.dismiss();
    } catch (error) {
      await EasyLoading.dismiss();
      return Future.error(error);
    }
  }
}

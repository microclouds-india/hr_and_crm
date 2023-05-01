import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/repository/addHoliday/model/add_holiday_model.dart';
import 'package:http/http.dart' as http;

class AttendanceReportNetworking {
  String endpoint = 'https://cashbes.com/attendance/apis/attend_report';


  // ignore: body_might_complete_normally_nullable
  attendaceReport(
      {required String id,
      required String date,
      required String month,
      required String year,
      required BuildContext context}) async {
    try {
      var url = Uri.parse(endpoint);
      var response = await http.post(url, body: {
        'employee_id': id,
        'date': date,
        'month': month,
        'year':year,
      });
      if (response.statusCode == 200) {
       
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

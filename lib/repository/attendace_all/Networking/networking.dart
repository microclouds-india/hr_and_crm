import 'dart:convert';

import 'package:hr_and_crm/repository/attendace_all/model/attendance_all_model.dart';
import 'package:http/http.dart' as http;

class AttendanceAllNetworking {
  String endpoint = 'https://cashbes.com/attendance/apis/attendance_all';
  late AttendanceAllModel attendanceAllModel;

  Future<AttendanceAllModel?> getData() async {
    try {
      var url = Uri.parse(endpoint);
      var response = await http.post(url);
      if (response.statusCode == 200) {
        print(response.body);
        var json = jsonDecode(response.body);
        attendanceAllModel = AttendanceAllModel.fromJson(json);
        print(response.body);
      }
    } catch (e) {
      print('Error$e');
      return Future.error(e);
    }
    return attendanceAllModel;
  }
}

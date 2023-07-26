import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';
import 'package:http/http.dart' as http;

class EmployeeLeaveRequistesNetworking {
  late EmployeeLeaveRequistesModel model;

 Future<EmployeeLeaveRequistesModel> getData() async {
    try {
      final prif = await SharedPreferences.getInstance();
      var url = Uri.parse(
          'https://cashbes.com/attendance/apis/employee_leave_requests');
      var response =
          await http.post(url, body: {'token': prif.getString('token')});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        model = EmployeeLeaveRequistesModel.fromJson(json);
      }
    } catch (e) {
      print(e);
    }
    return model;
  }
}

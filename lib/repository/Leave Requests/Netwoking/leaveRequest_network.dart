import 'dart:convert';

import 'package:hr_and_crm/repository/Leave%20Requests/Model/leaveRequestsModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LeaveRequestNetworking {
  String endPoint = 'https://cashbes.com/attendance/apis/leave_requests';
  late LeaveRequestModel leaveRequestModel;

  Future<LeaveRequestModel?> getRequestData() async {
    final prif = await SharedPreferences.getInstance();
    try {
      final url = Uri.parse(endPoint);
      final response = await http.post(url,body: {
        'token':prif.getString('token')
      });
      if (response.statusCode == 200) {
        print(response.body);
        var json = jsonDecode(response.body);
        leaveRequestModel = LeaveRequestModel.fromJson(json);
      }
    } catch (e) {
      return Future.error(e);
    }
    return leaveRequestModel;
  }
}

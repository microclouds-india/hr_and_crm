import 'dart:convert';

import 'package:hr_and_crm/repository/Leave%20Requests/Model/leaveRequestsModel.dart';
import 'package:http/http.dart' as http;

class LeaveRequestNetworking {
  String endPoint = 'https://cashbes.com/attendance/apis/leave_requests';
  late LeaveRequestModel leaveRequestModel;

  Future<LeaveRequestModel?> getRequestData() async {
    try {
      final url = Uri.parse(endPoint);
      final response = await http.post(url);
      if (response.statusCode == 200) {
        print(response.body);
        var json = jsonDecode(response.body);
        leaveRequestModel = LeaveRequestModel.fromJson(json);
        print('FFFFFFFFFFFFFFFFFFFFFFF${leaveRequestModel.data![0].reason ?? 'No data'}');
      }
    } catch (e) {
      return Future.error(e);
    }
    return leaveRequestModel;
  }
}

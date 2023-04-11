import 'dart:convert';
import 'package:hr_and_crm/repository/branches/model/branches.model.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:hr_and_crm/repository/holidays/model/holidays.model.dart';
import 'package:hr_and_crm/repository/leaveTypes/model/leaveTypes.model.dart';
import 'package:http/http.dart' as http;

class LeaveTypesNetworking {
  static const String urlENDPOINT = "https://cashbes.com/attendance/apis/leavetypes";

  final client = http.Client();

  late LeavetypesModel leavetypesModel;

  Future<LeavetypesModel> getLeaveTypes() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT)).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        leavetypesModel = LeavetypesModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return leavetypesModel;
  }
}
import 'dart:convert';
import 'package:hr_and_crm/repository/employeeDetails/model/employeeDetails.model.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:http/http.dart' as http;

class EmployeeDetailsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/attendance/apis/employee_view";

  final client = http.Client();

  late EmployeeDetailsModel employeesDetailsModel;

  Future<EmployeeDetailsModel> getEmployeeDetails({required String employeeId}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "id": employeeId,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        employeesDetailsModel = EmployeeDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return employeesDetailsModel;
  }
}
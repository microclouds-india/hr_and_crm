import 'dart:convert';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:http/http.dart' as http;

class EmployeeNetworking {
  static const String urlENDPOINT = "https://cashbes.com/attendance/apis/employees";

  final client = http.Client();

  late EmployeesModel employeesModel;

  Future<EmployeesModel> getEmployee() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT)).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        employeesModel = EmployeesModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return employeesModel;
  }
}
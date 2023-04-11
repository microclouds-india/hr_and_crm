import 'dart:convert';
import 'package:hr_and_crm/repository/addEmployees/model/addEmployees.model.dart';
import 'package:hr_and_crm/repository/branches/model/branches.model.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:hr_and_crm/repository/holidays/model/holidays.model.dart';
import 'package:hr_and_crm/repository/leaveTypes/model/leaveTypes.model.dart';
import 'package:http/http.dart' as http;

class AddEmployeesNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/attendance/apis/add_employee";

  final client = http.Client();

  late AddEmployeesModel addEmployeesModel;

  Future<AddEmployeesModel> getAddEmployees({
    required String name,
    required String dob,
    required String email,
    required String city,
    required String gender,
    required String address,
    required String phone,
  }) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "name": name,
        "dob": dob,
        "email": email,
        "city": city,
        "gender": gender,
        "address": address,
        "phone": phone,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        addEmployeesModel = AddEmployeesModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return addEmployeesModel;
  }
}

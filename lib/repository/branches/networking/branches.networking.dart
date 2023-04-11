import 'dart:convert';
import 'package:hr_and_crm/repository/branches/model/branches.model.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:http/http.dart' as http;

class BranchesNetworking {
  static const String urlENDPOINT = "https://cashbes.com/attendance/apis/branches";

  final client = http.Client();

  late BranchesModel branchesModel;

  Future<BranchesModel> getBranches() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT)).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        branchesModel = BranchesModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return branchesModel;
  }
}
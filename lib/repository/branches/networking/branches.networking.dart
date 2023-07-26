import 'dart:convert';
import 'package:hr_and_crm/repository/branches/model/branches.model.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BranchesNetworking {
  static const String urlENDPOINT = "https://cashbes.com/attendance/apis/companywise_branches";

  final client = http.Client();

  late BranchesModel branchesModel;

  Future<BranchesModel> getBranches() async {
    try {
      final prif = await SharedPreferences.getInstance();
      final request = await client.post(Uri.parse(urlENDPOINT),body: {
        'company_id':prif.getString('MyCompanyId').toString()
      }).timeout(const Duration(seconds: 10));

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
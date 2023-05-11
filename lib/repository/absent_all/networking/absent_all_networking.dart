import 'dart:convert';

import 'package:hr_and_crm/repository/absent_all/model/absent_all_model.dart';
import 'package:http/http.dart' as http;

class AbsentAllNetworking {
  late AbsentAllModel absentAllModel;

  Future<AbsentAllModel> absentAll() async {
    try {
      var response = await http
          .post(Uri.parse('https://cashbes.com/attendance/apis/absents_all'));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        absentAllModel = AbsentAllModel.fromJson(json);
      }
    } catch (e) {
      throw Exception(e);
    }
    return absentAllModel;
  }
}

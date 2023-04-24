import 'dart:convert';

import 'package:hr_and_crm/repository/clock_out/model/clock_OUT_model.dart';
import 'package:http/http.dart' as http;

class ClockOUTNetwork {
  String endpoint = 'https://cashbes.com/attendance/apis/clock_out';
  late ClockOutModel clockOutModel;

  Future<ClockOutModel?> clockOUT(
      {required String token,
      required String id,
      required String clockOutime,
      required String attendDate}) async {
    try {
      var url = Uri.parse(endpoint);
      var response = await http.post(url, body: {
        'token': token,
        'id': id,
        'clock_out': clockOutime,
        'attend_date': attendDate
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        clockOutModel = ClockOutModel.fromJson(json);
        print(response.body);
      }
    } catch (e) {
      return Future.error(e);
    }
    return clockOutModel;
  }
}

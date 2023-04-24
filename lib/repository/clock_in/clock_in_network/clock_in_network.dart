import 'dart:convert';

import 'package:hr_and_crm/repository/clock_in/model/clock_in_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClockINNetWork {
  String endpoint = 'https://cashbes.com/attendance/apis/clock_in';
  late ClockInModel clockInModel;

  Future<ClockInModel?> clockINnetwork(String date, String time,String token) async {
    
    try {
      var url = Uri.parse(endpoint);
      var response = await http.post(url, body: {
        'token': token,
        'attend_date': date,
        'clock_in': time
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        clockInModel = ClockInModel.fromJson(json);
        print(response.body);
      }
    } catch (error) {
      return Future.error(error);
    }
    return clockInModel;
  }
}

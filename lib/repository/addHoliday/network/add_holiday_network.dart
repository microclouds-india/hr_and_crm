import 'dart:convert';

import 'package:hr_and_crm/repository/addHoliday/model/add_holiday_model.dart';
import 'package:http/http.dart' as http;

class AddHolidayNetwork {
  String endpoint = 'https://cashbes.com/attendance/apis/add_holiday';
  late AddHolidayModel addHolidayModel;

  // ignore: body_might_complete_normally_nullable
  Future<AddHolidayModel?> addHoliDay(
      {required String year,
      required String holidayDate,
      required String title}) async {
    try {
      var url = Uri.parse(endpoint);
      var response = await http.post(url, body: {
        'year': year,
        'holiday_date': holidayDate,
        'title': title,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        addHolidayModel = AddHolidayModel.fromJson(json);
        print(response.body);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class ClockInViewNetworks {
  late ClockInViewModel model;

  Future<ClockInViewModel> getData(String token, BuildContext context) async {
    try {
      var endpoint = 'https://cashbes.com/attendance/apis/clock_in_view';
      var response =
          await http.post(Uri.parse(endpoint), body: {'token': token});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        model = ClockInViewModel.fromJson(json);
      }
    } catch (e) {
      print(e);
    }
    return model;
  }
}

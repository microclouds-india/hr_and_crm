import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_and_crm/common/ui.dart';

import '../model/model.dart';
import 'package:http/http.dart' as http;

class HrWorkRepotsNetworks {
 late  HrWorkrepoertsModel model;
 Future<HrWorkrepoertsModel>getData(String token,BuildContext context)async{
  try {
    var url = Uri.parse('https://cashbes.com/attendance/apis/work_reports');
    var response = await http.post(url,body: {
      'token':token
    });
    if (response.statusCode==200) {
      var json = jsonDecode(response.body);
      model = HrWorkrepoertsModel.fromJson(json);
    }
  } catch (e) {
    Ui.getSnackBar(title: 'Server Error', context: context);
  }
  return model;
 }
}
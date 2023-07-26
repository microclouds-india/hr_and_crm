import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditWorkreportNotifier extends ChangeNotifier {
  editWorkReport(String id,String reportMsg,String title,BuildContext context)async{
    try {
      EasyLoading.show(status: 'Please Wait...');
      final prif = await SharedPreferences.getInstance();
      var url = Uri.parse('https://cashbes.com/attendance/apis/edit_work_report');
      var response = await http.post(url,body: {
        'id':id,
        'token':prif.getString('token'),
        'report_message':reportMsg,
        'title':title
      });
      if (response.statusCode==200) {
        var json = jsonDecode(response.body);
        if (json['status']==200) {
          EasyLoading.dismiss();
          Ui.getSnackBar(title: 'Your work report successfully edited', context: context);
        }else{
          EasyLoading.dismiss();
        }
      }else{
        EasyLoading.dismiss();
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();

    }
  }
}
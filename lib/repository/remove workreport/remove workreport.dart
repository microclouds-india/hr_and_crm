import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart' as http;

class RemoveWorkreportNotifier extends ChangeNotifier {
  removeWorkreport(String id,BuildContext context)async{
    try {
      EasyLoading.show(status: 'Plase Wait...');
      var url = Uri.parse('https://cashbes.com/attendance/apis/workreport_remove');
      var response = await http.post(url ,body: {
        'id': id
      });
      if (response.statusCode==200) {
        var json = jsonDecode(response.body);
        if (json['status']=='200') {
          Ui.getSnackBar(title: 'Workreport Removed!', context: context);
          EasyLoading.dismiss();
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
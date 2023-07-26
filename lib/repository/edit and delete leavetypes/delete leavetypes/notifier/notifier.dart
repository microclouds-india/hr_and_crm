// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart' as http;

class LeaveTypeRemoveNotifier extends ChangeNotifier{
 getdata(String id,BuildContext context)async{
  try {
    EasyLoading.show(status: 'Please wait...');
    var url = Uri.parse('https://cashbes.com/attendance/apis/leavetypes_remove');
    var respinse = await http.post(url,body: {
      'id':id
    });
  if (respinse.statusCode==200) {
    var json = jsonDecode(respinse.body);
    if (json['status']=='200') {
      Ui.getSnackBar(title: 'Leave type deleted!', context: context);
      EasyLoading.dismiss();
    }
  }else{
    EasyLoading.dismiss();
  }
  } catch (e) {
    EasyLoading.dismiss();
    print(e);
  }
 }
}
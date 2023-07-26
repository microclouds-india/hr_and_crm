import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/Leave%20typs/leaveTypes.dart';

import '../model/model.dart';
import 'package:http/http.dart' as http;

class EditLeaveTypesNettworking{
 late EditLeaveTypesModel model;


 getData(String id,String type,BuildContext context)async{
  try {
    EasyLoading.show(status: 'Pleas Wait...');
    var url = Uri.parse('https://cashbes.com/attendance/apis/edit_leavetypes');
    var response = await http.post(url,body: {
      'id':id,
      'leave_type':type
    });
    if (response.statusCode==200) {
      var json = jsonDecode(response.body);
      model = EditLeaveTypesModel.fromJson(json);
      Ui.getSnackBar(title: 'LeaveType Edited', context: context);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return LeaveTypesScreen();
      }));
      EasyLoading.dismiss();
    }else{
      EasyLoading.dismiss();
    }
  } catch (e) {
    print(e);
    EasyLoading.dismiss();
  }
  return model;
 }
}
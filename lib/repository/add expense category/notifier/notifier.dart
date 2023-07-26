import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddExpenseNotifier extends ChangeNotifier{

AdExpenseCategory(String expenseTitle,BuildContext context)async{
try {
  EasyLoading.show(status: 'Please Wait...');
  final prif = await SharedPreferences.getInstance();
  var url = Uri.parse('https://cashbes.com/attendance/apis/add_expense_category');
  var response = await http.post(url,body: {
    'exp_category': expenseTitle,
    'token':prif.getString('token')
  });
  if (response.statusCode==200) {
    var json = jsonDecode(response.body);
    if (json['status']=='200') {
    EasyLoading.dismiss();
    Ui.getSnackBar(title: 'New category added', context: context);
    }else{
      EasyLoading.dismiss();
      Ui.getSnackBar(title: 'Category not added', context: context);
    }
  }

} catch (e) {
  
}
}

}
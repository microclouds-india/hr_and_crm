import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/Employee%20expense/employeeExpenceScreen.dart';
import 'package:http/http.dart' as http;

class AddEmployeeExpenseNotifier extends ChangeNotifier {
  


addExpense(String employerId,String exData,String exType,String exAmount,BuildContext context)async{
  try {
    EasyLoading.show(status: 'Please Wait...');
    var url = Uri.parse('https://cashbes.com/attendance/apis/add_expense_employee');
    var response = await http.post(url,body: {
      'employee_id':employerId,
      'exp_date':exData,
      'exp_type':exType,
      'exp_amount':exAmount
    });
    if (response.statusCode==200) {
      var json = jsonDecode(response.body);
      if (json['status']=='200') {
        EasyLoading.dismiss();
        Ui.getSnackBar(title: 'Employee Expense Added!', context: context);
        Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return  EmployeeExpenseScreen();
                }));
      }else{
        EasyLoading.dismiss();
      }
    }else{
      EasyLoading.dismiss();
    }
  } catch (e) {
    EasyLoading.dismiss();
  }
}

}
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:hr_and_crm/ui/Leave%20typs/leaveTypes.dart';
import 'package:http/http.dart' as http;

class AddLeaveTypeNotifier extends ChangeNotifier {
  fetchData(String txt,BuildContext context)async{
    try {
      EasyLoading.show(status: 'Please Wait...');
      var url = Uri.parse('https://cashbes.com/attendance/apis/add_leavetype');
      var response = await http.post(url,body: {
        'leave_type':txt
      });
      if (response.statusCode==200) {
        Ui.getSnackBar(title: 'Successfully added', context: context);
        EasyLoading.dismiss();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return LeaveTypesScreen();
        }));

      }else{
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }
}
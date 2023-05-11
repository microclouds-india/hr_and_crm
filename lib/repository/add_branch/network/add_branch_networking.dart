import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/common/ui.dart';
import 'package:http/http.dart' as http;

class AddBranchNetworking {
  Future<http.Response> addBranch(
      {required String branchName,
      required String address,
      required BuildContext context}) async {
    EasyLoading.show(status: 'loading...');

    var response = await http.post(
        Uri.parse('https://cashbes.com/attendance/apis/add_branch'),
        body: {'branch_name': branchName, 'address': address});
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed('/Branches');
      print(response.body);
      EasyLoading.dismiss();
      Ui.getSnackBar(title: 'Branch Added', context: context);
    } else {
      EasyLoading.dismiss();
      Ui.getSnackBar(title: 'Braches not added', context: context);
      print('Error');
    }
    return response;
  }
}

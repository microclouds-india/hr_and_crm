import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/repository/log%20out/networking/logout_networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutNotifier extends ChangeNotifier {
  LogOutNewtworking logOutNewtworking = LogOutNewtworking();

  // // ignore: non_constant_identifier_names
  // LogOut(BuildContext context) async {
  //   await EasyLoading.show(status: 'Please Wait...');
  //   final prif = await SharedPreferences.getInstance();
  //   // ignore: use_build_context_synchronously
  //   logOutNewtworking.logout(, context);
  //   await EasyLoading.dismiss();
  // }
}

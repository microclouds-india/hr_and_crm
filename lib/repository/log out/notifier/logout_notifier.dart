import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/repository/log%20out/networking/logout_networking.dart';
import 'package:hr_and_crm/ui/login%20Screens/numberScreen.dart';
import 'package:hr_and_crm/ui/login/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutNotifier extends ChangeNotifier {
  LogOutNewtworking logOutNewtworking = LogOutNewtworking();

  LogOut(BuildContext context) async {
    await EasyLoading.show(status: 'Please Wait...');
    final prif = await SharedPreferences.getInstance();
    logOutNewtworking.logout(prif.getString('token')!, context);
    await EasyLoading.dismiss();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/repository/clock_in/clock_in_network/clock_in_network.dart';
import 'package:hr_and_crm/repository/clock_in/model/clock_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockINNotifier extends ChangeNotifier {
  bool isLoading = false;
  final ClockINNetWork clockINNetWork = ClockINNetWork();
  late ClockInModel clockInModel;
  bool isAttended = false;

  loading(bool isloading) {
    this.isLoading = isloading;
    notifyListeners();
  }

  attend(bool attend) async {
    final prif = await SharedPreferences.getInstance();
    this.isAttended = attend;
    prif.setBool('Attend', isAttended);
    notifyListeners();
  }

  clockIN(String date, String time, String token, BuildContext context) async {
    try {
      loading(true);
      
      clockInModel =
          (await clockINNetWork.clockINnetwork(date, time, token, context))!;
      loading(false);
      
      return clockInModel;
    } catch (e) {
      loading(true);
    }
  }

  Future<String?> getPrif() async {
    final prif = await SharedPreferences.getInstance();
    String token = prif.getString('token')!;
    return token;
  }
}

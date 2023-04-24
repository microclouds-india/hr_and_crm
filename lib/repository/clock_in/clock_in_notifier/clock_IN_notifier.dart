import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/clock_in/clock_in_network/clock_in_network.dart';
import 'package:hr_and_crm/repository/clock_in/model/clock_in_model.dart';

class ClockINNotifier extends ChangeNotifier {
  bool isLoading = false;
  final ClockINNetWork clockINNetWork = ClockINNetWork();
  late ClockInModel clockInModel;

  loading(bool isloading) {
    this.isLoading = isloading;
    notifyListeners();
  }

  clockIN(String date, String time,String token) async {
    try {
      loading(true);
      clockInModel = (await clockINNetWork.clockINnetwork(date, time,token))!;
      loading(false);
      return clockInModel;
    } catch (e) {
      loading(true);
    }
  }
}

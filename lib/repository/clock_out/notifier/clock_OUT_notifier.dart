import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/clock_in/model/clock_in_model.dart';
import 'package:hr_and_crm/repository/clock_out/clock_out_network/clock_out_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockOUTNotifier extends ChangeNotifier {
  bool isLoading = false;
  late ClockInModel clockInModel;
  final ClockOUTNetwork clockOUTNetwork = ClockOUTNetwork();

  loading(bool isloading) {
    this.isLoading = isloading;
    notifyListeners();
  }

  clockOut(
      {required String clockin,
      required String id,
      required String clockOuttime,
      required BuildContext context,
      required String attendDate}) async {
    final prif = await SharedPreferences.getInstance();
    String token = prif.getString('token').toString();

    try {
      loading(true);
       clockOUTNetwork.clockOUT(
          clockin: clockin,
          context: context,
          token: token,
          id: id,
          clockOutime: clockOuttime,
          attendDate: attendDate);
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

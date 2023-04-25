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
      {required String id,
      required String clockOuttime,
      required BuildContext context,
      required String attendDate}) async {
    final prif = await SharedPreferences.getInstance();
    String token = prif.getString('token').toString();

    try {
      loading(true);
      clockInModel = (await clockOUTNetwork.clockOUT(
        context: context,
          token: token,
          id: prif.getString('emploee_id')!,
          clockOutime: '5:00',
          attendDate: '2023-04-23')) as ClockInModel;
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

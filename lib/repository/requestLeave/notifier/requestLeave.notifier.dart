import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/holidays/model/holidays.model.dart';
import 'package:hr_and_crm/repository/holidays/networking/holidays.networking.dart';

class RequestLeaveNotifier extends ChangeNotifier {
  final HolidaysNetworking _holidaysNetworking = HolidaysNetworking();

  bool isLoading = false;
  late String employeeId = "";

  late HolidaysModel holidaysModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getHolidays() async {
    loading(true);
    try {
      holidaysModel = await _holidaysNetworking.getHolidays();
      loading(false);
      return holidaysModel;
    } catch (e) {
      loading(false);
    }
  }
}
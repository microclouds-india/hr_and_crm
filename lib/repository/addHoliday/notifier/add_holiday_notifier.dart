import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/addHoliday/model/add_holiday_model.dart';
import 'package:hr_and_crm/repository/addHoliday/network/add_holiday_network.dart';

class AddHolidayNotifier extends ChangeNotifier {
  bool isLoading = false;
  final AddHolidayNetwork addHolidayNetwork = AddHolidayNetwork();
  late AddHolidayModel addHolidayModel;

  loading(bool isloading) {
    isLoading = isloading;
    notifyListeners();
  }

  addHolidays(
      {required String year,
      required String holidayDate,
      required String tittle}) async {
    try {
      loading(true);
      addHolidayModel = (await addHolidayNetwork.addHoliDay(
          year: year, holidayDate: holidayDate, title: tittle))!;
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

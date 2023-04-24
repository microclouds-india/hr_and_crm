import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/addHoliday/model/add_holiday_model.dart';
import 'package:hr_and_crm/repository/addHoliday/network/add_holiday_network.dart';

class AddHolidayNotifier extends ChangeNotifier {
  bool isLoading = false;
  final AddHolidayNetwork addHolidayNetwork = AddHolidayNetwork();
  late AddHolidayModel addHolidayModel;
  String year = '';
  String date = '';
  loading(bool isloading) {
    isLoading = isloading;
    notifyListeners();
  }

  addDate(String year, String date) {
    this.year = year;
    print(year);
    this.date = date;
    print(date);
  }

  addHolidays(
      {required String year,
      required String holidayDate,
      required String tittle,required BuildContext context}) async {
    try {
      loading(true);
      addHolidayModel = (await addHolidayNetwork.addHoliDay(
        context: context,
          year: year, holidayDate: holidayDate, title: tittle))!;
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

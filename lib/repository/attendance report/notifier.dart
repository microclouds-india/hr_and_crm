import 'package:flutter/material.dart';

import 'network/attendance_repoert_nwtwork.dart';

class AttendanceReportNotifier extends ChangeNotifier {
  bool isLoading = false;
  AttendanceReportNetworking attendanceReportNetworking =
      AttendanceReportNetworking();

  loading(bool isloading) {
    isLoading = isloading;
    notifyListeners();
  }

  getData(
      {required String id,
      required String date,
      required String month,
      required String year,
      required BuildContext context}) async {
    try {
      loading(true);
      attendanceReportNetworking.attendaceReport(
          id: id, date: date, month: month, year: year, context: context);
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

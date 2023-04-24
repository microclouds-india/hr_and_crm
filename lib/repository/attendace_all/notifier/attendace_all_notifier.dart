import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/attendace_all/Networking/networking.dart';
import 'package:hr_and_crm/repository/attendace_all/model/attendance_all_model.dart';

class AttendaceAllNotifier extends ChangeNotifier {
  bool isLoading = false;
  final AttendanceAllNetworking attendanceAllNetworking =
      AttendanceAllNetworking();
  late AttendanceAllModel attendanceAllModel;
  loading(bool isloading) {
    this.isLoading = isloading;
    notifyListeners();
  }

  getDatas() async {
    loading(true);
    try {
      attendanceAllModel = (await attendanceAllNetworking.getData())!;
      loading(false);
      return attendanceAllModel;
    } catch (e) {
      print('Error$e');
      loading(false);
    }
  }
}

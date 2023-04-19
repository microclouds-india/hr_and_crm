import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/holidays/model/holidays.model.dart';
import 'package:hr_and_crm/repository/requestLeave/model/requestLeave.model.dart';
import 'package:hr_and_crm/repository/requestLeave/networking/requestLeave.networking.dart';

class HolidaysNotifier extends ChangeNotifier {
  final RequestLeaveNetworking _requestLeaveNetworking = RequestLeaveNetworking();

  bool isLoading = false;
  late String employeeId = "";

  late RequestLeaveModel requestLeaveModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getRequestLeave() async {
    loading(true);
    try {
      requestLeaveModel = await _requestLeaveNetworking.getRequestLeave();
      loading(false);
      return requestLeaveModel;
    } catch (e) {
      loading(false);
    }
  }
}
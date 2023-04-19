import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/leaveTypes/model/leaveTypes.model.dart';
import 'package:hr_and_crm/repository/leaveTypes/networking/leaveTypes.networking.dart';

class LeaveTypesNotifier extends ChangeNotifier {
  final LeaveTypesNetworking _leaveTypesNetworking = LeaveTypesNetworking();

  bool isLoading = false;
  late String employeeId = "";
  var leaveReason;

  late LeavetypesModel leavetypesModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getLeaveTypes() async {
    loading(true);
    try {
      leavetypesModel = await _leaveTypesNetworking.getLeaveTypes();
      loading(false);
      return leavetypesModel;
    } catch (e) {
      loading(false);
    }
  }

  getLeaveReason(String reason) async {
    leaveReason = reason;
    notifyListeners();
  }
}
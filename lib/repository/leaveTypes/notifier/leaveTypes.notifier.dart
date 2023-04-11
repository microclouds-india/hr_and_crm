import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/branches/model/branches.model.dart';
import 'package:hr_and_crm/repository/branches/networking/branches.networking.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:hr_and_crm/repository/employees/networking/employee.networking.dart';
import 'package:hr_and_crm/repository/holidays/model/holidays.model.dart';
import 'package:hr_and_crm/repository/holidays/networking/holidays.networking.dart';
import 'package:hr_and_crm/repository/leaveTypes/model/leaveTypes.model.dart';
import 'package:hr_and_crm/repository/leaveTypes/networking/leaveTypes.networking.dart';

class LeaveTypesNotifier extends ChangeNotifier {
  final LeaveTypesNetworking _leaveTypesNetworking = LeaveTypesNetworking();

  bool isLoading = false;
  late String employeeId = "";

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
}
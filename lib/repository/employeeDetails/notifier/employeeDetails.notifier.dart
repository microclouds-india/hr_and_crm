import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/employeeDetails/model/employeeDetails.model.dart';
import 'package:hr_and_crm/repository/employeeDetails/networking/employeeDetails.networking.dart';

class EmployeeDetailsNotifier extends ChangeNotifier {
  final EmployeeDetailsNetworking _employeeDetailsNetworking = EmployeeDetailsNetworking();

  bool isLoading = false;

  late EmployeeDetailsModel employeesDetailsModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getEmployeeDetails({required String employeeId}) async {
    loading(true);
    try {
      employeesDetailsModel = await _employeeDetailsNetworking.getEmployeeDetails(employeeId: employeeId);
      loading(false);
      return employeesDetailsModel;
    } catch (e) {
      loading(false);
    }
  }
}
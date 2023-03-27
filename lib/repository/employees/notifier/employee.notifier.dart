import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:hr_and_crm/repository/employees/networking/employee.networking.dart';

class EmployeeNotifier extends ChangeNotifier {
  final EmployeeNetworking _employeeNetworking = EmployeeNetworking();

  bool isLoading = false;
  late String employeeId = "";

  late EmployeesModel employeesModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getEmployees() async {
    loading(true);
    try {
      employeesModel = await _employeeNetworking.getEmployee();
      loading(false);
      return employeesModel;
    } catch (e) {
      loading(false);
    }
  }
}
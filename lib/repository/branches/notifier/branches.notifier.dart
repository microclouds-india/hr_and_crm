import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/branches/model/branches.model.dart';
import 'package:hr_and_crm/repository/branches/networking/branches.networking.dart';
import 'package:hr_and_crm/repository/employees/model/employee.model.dart';
import 'package:hr_and_crm/repository/employees/networking/employee.networking.dart';

class BranchesNotifier extends ChangeNotifier {
  final BranchesNetworking _branchesNetworking = BranchesNetworking();

  bool isLoading = false;
  late String employeeId = "";

  late BranchesModel branchesModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getBranches() async {
    loading(true);
    try {
      branchesModel = await _branchesNetworking.getBranches();
      loading(false);
      return branchesModel;
    } catch (e) {
      loading(false);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/addEmployees/model/addEmployees.model.dart';
import 'package:hr_and_crm/repository/addEmployees/networking/addEmployees.networking.dart';

class AddEmployeesNotifier extends ChangeNotifier {
  final AddEmployeesNetworking _addEmployeesNetworking =
      AddEmployeesNetworking();

  bool isLoading = false;
  late AddEmployeesModel addEmployeesModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getAddEmployees({
    required String name,
    required String dob,
    required String email,
    required String city,
    required String gender,
    required String address,
    required String phone,
  }) async {
    loading(true);
    try {
      addEmployeesModel = await _addEmployeesNetworking.getAddEmployees(
        name: name,
        dob: dob,
        email: email,
        city: city,
        gender: gender,
        address: address,
        phone: phone,
      );
      loading(false);
      return addEmployeesModel;
    } catch (e) {
      loading(false);
    }
  }
}

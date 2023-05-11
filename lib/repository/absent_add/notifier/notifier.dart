import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/absent_add/networking/add_absent_networking.dart';

class AddAbsentNotifier extends ChangeNotifier {
  AddAbsentNetworking addAbsentNetworking = AddAbsentNetworking();
  postAbsentData() async {
    addAbsentNetworking.postData(employeeId: '19');
  }
}

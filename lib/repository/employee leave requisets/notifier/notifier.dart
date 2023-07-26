import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/employee%20leave%20requisets/model/model.dart';
import 'package:hr_and_crm/repository/employee%20leave%20requisets/network/networking.dart';

class EmployeeLeaveRequistsNotifier extends ChangeNotifier {
  late EmployeeLeaveRequistesModel model;
  final EmployeeLeaveRequistesNetworking networking = EmployeeLeaveRequistesNetworking();

Future<EmployeeLeaveRequistesModel> fetchData()async{
  try {
    model = await networking.getData();
  } catch (e) {
    print(e);
  }
  return model;
}


}
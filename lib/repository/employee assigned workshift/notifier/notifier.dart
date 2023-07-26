import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/employee%20assigned%20workshift/model/model.dart';
import 'package:hr_and_crm/repository/employee%20assigned%20workshift/networking/networking.dart';

class EmployeeAssignedWorkShiftNotier extends ChangeNotifier {
  final EmployeeAssignedWorkReportNetworking networking = EmployeeAssignedWorkReportNetworking();
  late EmployeeAssignedWorkShiftModel model;
  

Future<EmployeeAssignedWorkShiftModel> fecthData()async{
  try {
    model = await networking.getData();
  } catch (e) {
    print(e);
  }
  return model;
}

}
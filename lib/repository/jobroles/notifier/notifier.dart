import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/jobroles/model/model.dart';
import 'package:hr_and_crm/repository/jobroles/networking/networking.dart';

class JobRolesNotifier extends ChangeNotifier {
  late JobRolesModel model;
  final JobRolesNetworking networking = JobRolesNetworking();

Future<JobRolesModel> fetchData(String id)async{
  try {
    model = await networking.getData(id);
  } catch (e) {
    print(e);
  }
  return model;
}

}
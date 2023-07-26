import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/edit%20leave%20types/model/model.dart';
import 'package:hr_and_crm/repository/edit%20and%20delete%20leavetypes/edit%20leave%20types/networking/networking.dart';

class EditLeaveTyesNotifier extends  ChangeNotifier {
  late EditLeaveTypesModel model;
  final EditLeaveTypesNettworking nettworking = EditLeaveTypesNettworking();


  fetchData(String id ,String type,BuildContext context)async{
    try {
      model = await nettworking.getData(id, type,context);
    } catch (e) {
      print( e);
    }
  }
}
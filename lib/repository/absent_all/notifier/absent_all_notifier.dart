import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/absent_all/model/absent_all_model.dart';
import 'package:hr_and_crm/repository/absent_all/networking/absent_all_networking.dart';

class AbsentAllNotifier extends ChangeNotifier {
  late AbsentAllModel absentAllModel;
  final AbsentAllNetworking absentNetworking = AbsentAllNetworking();

  Future<AbsentAllModel> getData() async {
    try {
      absentAllModel = await absentNetworking.absentAll();
    } catch (a) {
      print(a);
    }
    return absentAllModel;
  }
}

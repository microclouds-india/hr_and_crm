import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/hr%20workreports/networks/networks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';

class HrWorkReportsNotifier extends ChangeNotifier {
  late HrWorkrepoertsModel model;
  final HrWorkRepotsNetworks networks = HrWorkRepotsNetworks();
  fetchData(BuildContext context)async{
    try {
      final prif = await SharedPreferences.getInstance();
      model = await networks.getData(prif.getString('token').toString(), context);
    } catch (e) {
      print(e);
    }
    return model;
  }
}
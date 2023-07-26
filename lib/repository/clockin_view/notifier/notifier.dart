import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/clockin_view/model/model.dart';
import 'package:hr_and_crm/repository/clockin_view/network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockInViewNotifier extends ChangeNotifier {
  late ClockInViewModel model;
  final ClockInViewNetworks networks = ClockInViewNetworks();

  Future <ClockInViewModel>fetchData(BuildContext context) async {
    try {
      final prif = await SharedPreferences.getInstance();
      model = await networks.getData(prif.getString('token').toString(), context);
    } catch (e) {
      print(e);
    }
    return model;
  }
}

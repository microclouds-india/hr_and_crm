import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/Clock%20in%20view/networking/networking.dart';

import '../model/model.dart';

class ClockInViewNotifier extends ChangeNotifier {
  bool isLoading = false;
  late ClockinviewModel clockinviewModel;
  final ClockinViewNetworking clockinViewNetworking = ClockinViewNetworking();

  loading(bool isloading) {
    isLoading = isloading;
    notifyListeners();
  }

  getData() async {
    try {
      loading(true);
      clockinViewNetworking.getData();
      loading(false);
    } catch (e) {
      loading(false);
    }
    return clockinViewNetworking.getData();
  }
}

import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/Leave%20Requests/Model/leaveRequestsModel.dart';
import 'package:hr_and_crm/repository/Leave%20Requests/Netwoking/leaveRequest_network.dart';

class leaveRequestNotifier extends ChangeNotifier {
  bool isLoading = false;
  final LeaveRequestNetworking leaveRequestNetworking =
      LeaveRequestNetworking();
  late LeaveRequestModel leaveRequestModel;
  loading(bool isloading) {
    this.isLoading = isloading;
    notifyListeners();
  }

  getDatas() async {
    loading(true);
    try {
      leaveRequestModel = (await leaveRequestNetworking.getRequestData())!;
      loading(false);
      return leaveRequestModel;
    } catch (e) {
      print('Error $e');
      loading(false);
    }
  }
}

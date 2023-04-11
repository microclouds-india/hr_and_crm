import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/login/model/login.model.dart';
import 'package:hr_and_crm/repository/login/networking/login.networking.dart';
import 'package:hr_and_crm/repository/profile/model/profile.model.dart';
import 'package:hr_and_crm/repository/profile/networking/profile.networking.dart';

class ProfileNotifier extends ChangeNotifier {
  final ProfileNetworking _profileNetworking = ProfileNetworking();

  bool isLoading = false;

  late ProfileModel profileModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getProfile({required String token}) async {
    loading(true);
    try {
      profileModel = await _profileNetworking.getProfile(token: token);
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

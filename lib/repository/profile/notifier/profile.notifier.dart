import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/profile/model/profile.model.dart';
import 'package:hr_and_crm/repository/profile/networking/profile.networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileNotifier extends ChangeNotifier {
  final ProfileNetworking _profileNetworking = ProfileNetworking();

  bool isLoading = false;

  late ProfileModel profileModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  getProfile() async {
    loading(true);
    try {
      final prif =await SharedPreferences.getInstance();
      profileModel = await _profileNetworking.getProfile(token: prif.getString('token').toString());
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

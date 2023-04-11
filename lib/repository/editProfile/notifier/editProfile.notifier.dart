import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/editProfile/model/editProfile.model.dart';
import 'package:hr_and_crm/repository/editProfile/networking/editProfile.networking.dart';
import 'package:hr_and_crm/repository/login/model/login.model.dart';
import 'package:hr_and_crm/repository/login/networking/login.networking.dart';
import 'package:hr_and_crm/repository/profile/model/profile.model.dart';
import 'package:hr_and_crm/repository/profile/networking/profile.networking.dart';

class EditProfileNotifier extends ChangeNotifier {
  final EditProfileNetworking _editProfileNetworking = EditProfileNetworking();

  bool isLoading = false;

  late EditProfileModel editProfileModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  editProfile({
    required String token,
    required String name,
    required String dob,
    required String email,
    required String city,
    required String gender,
    required String address,
  }) async {
    loading(true);
    try {
      editProfileModel = await _editProfileNetworking.editProfile(
        token: token,
        name: name,
        dob: dob,
        email: email,
        city: city,
        gender: gender,
        address: address,
      );
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

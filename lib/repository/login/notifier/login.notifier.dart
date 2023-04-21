import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/login/model/login.model.dart';
import 'package:hr_and_crm/repository/login/model/otp.model.dart';
import 'package:hr_and_crm/repository/login/model/register.model.dart';
import 'package:hr_and_crm/repository/login/networking/login.networking.dart';

class LoginNotifier extends ChangeNotifier {
  final LoginNetworking _loginNetworking = LoginNetworking();

  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;

  late LoginModel loginModel;
  late RegisterModel registerModel;
  late OtpModel otpModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  loading2(bool isLoading) {
    this.isLoading2 = isLoading;
    notifyListeners();
  }

  loading3(bool isLoading) {
    this.isLoading3 = isLoading;
    notifyListeners();
  }

  loginUser({required dynamic userName, required String password}) async {
    loading(true);
    try {
      loginModel = await _loginNetworking.loginUser(userName: userName, password: password);
      loading(false);
    } catch (e) {
      loading(false);
    }
    return loginModel;
  }

  registerUser({required dynamic phone}) async {
    loading2(true);
    try {
      registerModel = await _loginNetworking.registerUser(phone: phone);
      loading2(false);
    } catch (e) {
      loading2(false);
    }
    return registerModel;
  }

  registerUserwithotp({required dynamic phone, required dynamic otp}) async {
    loading3(true);
    try {
      otpModel = await _loginNetworking.registerUserwithotp(phone: phone, otp: otp);
      loading3(false);
    } catch (e) {
      loading3(false);
    }
    return otpModel;
  }
}

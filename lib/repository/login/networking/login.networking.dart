import 'dart:convert';
import 'package:hr_and_crm/repository/login/model/login.model.dart';
import 'package:hr_and_crm/repository/login/model/otp.model.dart';
import 'package:hr_and_crm/repository/login/model/register.model.dart';
import 'package:http/http.dart' as http;

class LoginNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/trader_login";
  static const String urlENDPOINTREGISTER = "https://cashbes.com/photography/login/index";
  static const String urlENDPOINTREGISTEROTP = "https://cashbes.com/photography/login/existuser_otp";

  final client = http.Client();

  late LoginModel loginModel;
  late RegisterModel registerModel;
  late OtpModel otpModel;

  Future<LoginModel> loginUser(
      {required String userName, required String password}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "username": userName,
        "password": password,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        loginModel = LoginModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return loginModel;
  }

  Future<RegisterModel> registerUser(
      {required String phone}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINTREGISTER), body: {
        "phone": phone,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        registerModel = RegisterModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return registerModel;
  }

  Future<OtpModel> registerUserwithotp(
      {required String phone, required String otp}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINTREGISTEROTP), body: {
        "phone": phone,
        "otp": otp,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        otpModel = OtpModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return otpModel;
  }
}

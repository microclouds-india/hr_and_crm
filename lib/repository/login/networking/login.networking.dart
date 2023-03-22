import 'dart:convert';
import 'package:hr_and_crm/repository/login/model/login.model.dart';
import 'package:http/http.dart' as http;

class LoginNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/trader_login";

  final client = http.Client();

  late LoginModel loginModel;

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
}

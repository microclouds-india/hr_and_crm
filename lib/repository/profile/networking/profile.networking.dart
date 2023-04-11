import 'dart:convert';
import 'package:hr_and_crm/repository/login/model/login.model.dart';
import 'package:hr_and_crm/repository/profile/model/profile.model.dart';
import 'package:http/http.dart' as http;

class ProfileNetworking {
  static const String urlENDPOINT = "https://cashbes.com/attendance/apis/my_profile";

  final client = http.Client();

  late ProfileModel profileModel;

  Future<ProfileModel> getProfile(
      {required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        profileModel = ProfileModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return profileModel;
  }
}

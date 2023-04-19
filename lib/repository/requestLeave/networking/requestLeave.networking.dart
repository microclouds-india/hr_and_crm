import 'dart:convert';
import 'package:hr_and_crm/repository/requestLeave/model/requestLeave.model.dart';
import 'package:http/http.dart' as http;

class RequestLeaveNetworking {
  static const String urlENDPOINT = "https://cashbes.com/attendance/apis/holidays";

  final client = http.Client();

  late RequestLeaveModel requestLeaveModel;

  Future<RequestLeaveModel> getRequestLeave() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT)).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        // final response = json.decode(request.body);
        // requestLeaveModel = RequestLeaveModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return requestLeaveModel;
  }
}
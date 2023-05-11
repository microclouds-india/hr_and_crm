import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';
import 'package:http/http.dart' as http;

class ClockinViewNetworking {
  late ClockinviewModel clockinviewModel;
 Future<Response?> getData() async {
    final prif = await SharedPreferences.getInstance();
    try {
      var uri = Uri.parse('https://cashbes.com/attendance/apis/employee_view');
      var response = await http.post(uri, body: {
        'token': prif.getString('token'),
      });
      return response;
    } catch (e) {
      Future.error(e);
    }
  }
}

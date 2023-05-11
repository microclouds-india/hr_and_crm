import 'package:hr_and_crm/repository/absent_add/model/model.dart';
import 'package:http/http.dart' as http;

class AddAbsentNetworking {
  postData({required String employeeId}) async {
    try {
      var headers = {
        'Cookie': 'ci_session=3b3fad33eee7f43c6206563eb8b3330f4317e948'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://cashbes.com/attendance/apis/add_absent'));
      request.fields.addAll({'employee_id': employeeId});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      Future.error(e);
    }
  }
}

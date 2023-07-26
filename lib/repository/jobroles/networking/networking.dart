import 'dart:convert';

import '../model/model.dart';
import 'package:http/http.dart' as http;

class JobRolesNetworking {
  late JobRolesModel model;

 Future<JobRolesModel> getData(String id)async{
    try {
      var url = Uri.parse('https://cashbes.com/attendance/apis/jobroles');
      var response = await http.post(url,body: {
        'company_id':id
      });
      if (response.statusCode==200) {
        var json = jsonDecode(response.body);
        model = JobRolesModel.fromJson(json);
      }
    } catch (e) {
      print(e);
    }
    return model;
  }
}
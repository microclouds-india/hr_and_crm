import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QRclockINNotifier {
  getData()async{
    try {
      final prif = await SharedPreferences.getInstance();
      var url = Uri.parse('https://cashbes.com/attendance/apis/clockinview_qr_attendance');
      var response =await http.post(url,body: {
        'token':prif.getString('token').toString()
      });
      if (response.statusCode==200) {
        var json = jsonDecode(response.body);
        if (json['status']=='200') {
         
        }
      }
    } catch (e) {
      
    }
  }
}
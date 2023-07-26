import 'dart:convert';

import '../model/model.dart';
import 'package:http/http.dart' as http;

class ExpenseCategoryNetworking {
  late ExpenseCategoryModel model;
 Future<ExpenseCategoryModel> getData(String tokn) async {
    try {
      var url =
          Uri.parse('https://cashbes.com/attendance/apis/expense_categories');
      var response = await http.post(url, body: {'token': tokn});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        model = ExpenseCategoryModel.fromJson(json);
      }
    } catch (e) {
      print(e);
    }
    return model;
  }
}

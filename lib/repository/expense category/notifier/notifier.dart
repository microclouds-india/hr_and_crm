import 'package:flutter/material.dart';
import 'package:hr_and_crm/repository/expense%20category/networking/networking.dart';

import '../model/model.dart';

class ExpenseCategoryNotifier extends ChangeNotifier {
  late ExpenseCategoryModel model;
  final ExpenseCategoryNetworking networking = ExpenseCategoryNetworking();

Future<ExpenseCategoryModel> fetchData(String token)async{
  try {
  model = await networking.getData(token);
  } catch (e) {
    print(e);
  }
  return model;
}

}
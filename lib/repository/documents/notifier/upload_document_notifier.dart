import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hr_and_crm/repository/documents/model/upload_documents_model.dart';
import 'package:hr_and_crm/repository/documents/networking/upload_documents_networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadDocumentsNotier extends ChangeNotifier {
  bool isLoading = false;
  final UploadDocumetsNetworking uploadDocumetsNetworking =
      UploadDocumetsNetworking();
  late DocumentsUploadModel documentsUploadModel;

  loading(bool isloading) {
    this.isLoading = isloading;
    notifyListeners();
  }

  UploadDatas(String documentName, String file, BuildContext context) async {
    final prif = await SharedPreferences.getInstance();
    String token = prif.getString('token').toString();
    loading(true);
    EasyLoading.show(status: 'loading...');
    try {
      documentsUploadModel = (await uploadDocumetsNetworking.UploadDocumets(
          context, documentName, file, token))!;
      loading(false);
      EasyLoading.dismiss();
      return documentsUploadModel;
    } catch (e) {
      print('Error:$e');
      EasyLoading.dismiss();
      loading(false);
    }
  }
}

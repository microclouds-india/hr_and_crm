import 'package:flutter/material.dart';
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

  UploadDatas(String documentName, String file) async {
    final prif = await SharedPreferences.getInstance();
    String token = prif.getString('token').toString();
    loading(true);
    try {
      documentsUploadModel = (await uploadDocumetsNetworking.UploadDocumets(
        documentName,
        file,
        token
      ))!;
      loading(false);
      return documentsUploadModel;
    } catch (e) {
      print('Error:$e');
      loading(false);
    }
  }
}

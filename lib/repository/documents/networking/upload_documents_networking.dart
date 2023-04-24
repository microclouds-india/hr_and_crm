import 'dart:convert';

import 'package:hr_and_crm/repository/documents/model/upload_documents_model.dart';
import 'package:http/http.dart' as http;

class UploadDocumetsNetworking {
  String endpoint = 'https://cashbes.com/attendance/apis/document_upload';
  late DocumentsUploadModel uploadModel;
  // ignore: non_constant_identifier_names
  Future<DocumentsUploadModel?> UploadDocumets(
      String documentName, String file,String token) async {
    try {
      var url = Uri.parse(endpoint);
      var response = await http.post(url, body: {
        'token': token,
        
        'title': documentName,
        'file[]': file,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        uploadModel = DocumentsUploadModel.fromJson(json);
      }
    } catch (e) {
      return Future.error(e);
    }
    return uploadModel;
  }
}

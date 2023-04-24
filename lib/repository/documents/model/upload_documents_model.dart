import 'dart:convert';

DocumentsUploadModel documentsUploadModelFromJson(String str) => DocumentsUploadModel.fromJson(json.decode(str));


class DocumentsUploadModel {
    DocumentsUploadModel({
        required this.message,
        required this.filename,
        required this.status,
    });

    String message;
    String filename;
    String status;

    factory DocumentsUploadModel.fromJson(Map<String, dynamic> json) => DocumentsUploadModel(
        message: json["message"],
        filename: json["filename"],
        status: json["status"],
    );
}

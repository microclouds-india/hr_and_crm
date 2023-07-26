// To parse this JSON data, do
//
//     final documetViewModel = documetViewModelFromJson(jsonString);

import 'dart:convert';

DocumetViewModel documetViewModelFromJson(String str) => DocumetViewModel.fromJson(json.decode(str));

String documetViewModelToJson(DocumetViewModel data) => json.encode(data.toJson());

class DocumetViewModel {
    String message;
    List<Datum> data;
    String status;

    DocumetViewModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory DocumetViewModel.fromJson(Map<String, dynamic> json) => DocumetViewModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    String id;
    String name;
    String title;
    String filename;
    DateTime tdate;
    String ttime;

    Datum({
        required this.id,
        required this.name,
        required this.title,
        required this.filename,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        filename: json["filename"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "filename": filename,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}


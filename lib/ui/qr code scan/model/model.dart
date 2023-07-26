// To parse this JSON data, do
//
//     final qrDataModel = qrDataModelFromJson(jsonString);

import 'dart:convert';

QrDataModel qrDataModelFromJson(String str) => QrDataModel.fromJson(json.decode(str));

String qrDataModelToJson(QrDataModel data) => json.encode(data.toJson());

class QrDataModel {
    String message;
    List<Datum> data;
    String status;

    QrDataModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory QrDataModel.fromJson(Map<String, dynamic> json) => QrDataModel(
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
    String name;
    DateTime tdate;
    String ttime;

    Datum({
        required this.name,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

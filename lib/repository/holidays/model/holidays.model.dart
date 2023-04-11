// To parse this JSON data, do
//
//     final holidaysModel = holidaysModelFromJson(jsonString);

import 'dart:convert';

HolidaysModel holidaysModelFromJson(String str) => HolidaysModel.fromJson(json.decode(str));

String holidaysModelToJson(HolidaysModel data) => json.encode(data.toJson());

class HolidaysModel {
  HolidaysModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory HolidaysModel.fromJson(Map<String, dynamic> json) => HolidaysModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)) ?? []),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.year,
    required this.holidayDate,
    required this.tdate,
    required this.ttime,
  });

  String id;
  String year;
  String holidayDate;
  String tdate;
  String ttime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    year: json["year"] ?? "",
    holidayDate: json["holiday_date"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "year": year,
    "holiday_date": holidayDate,
    "tdate": tdate,
    "ttime": ttime,
  };
}

// To parse this JSON data, do
//
//     final holiDayModel = holiDayModelFromJson(jsonString);

import 'dart:convert';

HoliDayModel holiDayModelFromJson(String str) => HoliDayModel.fromJson(json.decode(str));

String holiDayModelToJson(HoliDayModel data) => json.encode(data.toJson());

class HoliDayModel {
    String message;
    List<Datum> data;
    String status;

    HoliDayModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory HoliDayModel.fromJson(Map<String, dynamic> json) => HoliDayModel(
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
    String year;
    String title;
    String holidayDate;
    DateTime tdate;
    String ttime;

    Datum({
        required this.id,
        required this.year,
        required this.title,
        required this.holidayDate,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        year: json["year"],
        title: json["title"],
        holidayDate: json["holiday_date"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "title": title,
        "holiday_date": holidayDate,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

import 'dart:convert';

HoliDayModel holiDayModelFromJson(String str) => HoliDayModel.fromJson(json.decode(str));

class HoliDayModel {
    HoliDayModel({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory HoliDayModel.fromJson(Map<String, dynamic> json) => HoliDayModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
        this.id,
        this.year,
        this.holidayDate,
        this.tdate,
        this.ttime,
    });

    String? id;
    String? year;
    String? holidayDate;
    DateTime? tdate;
    String? ttime;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        year: json["year"],
        holidayDate: json["holiday_date"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );
}

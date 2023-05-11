// To parse this JSON data, do
//
//     final absentAll = absentAllFromJson(jsonString);

import 'dart:convert';

AbsentAllModel absentAllFromJson(String str) => AbsentAllModel.fromJson(json.decode(str));

String absentAllToJson(AbsentAllModel data) => json.encode(data.toJson());

class AbsentAllModel {
    String message;
    List<Datum> data;
    String status;

    AbsentAllModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory AbsentAllModel.fromJson(Map<String, dynamic> json) => AbsentAllModel(
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
    DateTime attendDate;
    String clockIn;
    String clockOut;
    String workTime;
    String status;
    String attendType;
    DateTime tdate;
    String ttime;

    Datum({
        required this.name,
        required this.attendDate,
        required this.clockIn,
        required this.clockOut,
        required this.workTime,
        required this.status,
        required this.attendType,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        attendDate: DateTime.parse(json["attend_date"]),
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        workTime: json["work_time"],
        status: json["status"],
        attendType: json["attend_type"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "attend_date": "${attendDate.year.toString().padLeft(4, '0')}-${attendDate.month.toString().padLeft(2, '0')}-${attendDate.day.toString().padLeft(2, '0')}",
        "clock_in": clockIn,
        "clock_out": clockOut,
        "work_time": workTime,
        "status": status,
        "attend_type": attendType,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

// To parse this JSON data, do
//
//     final attendanceAllModel = attendanceAllModelFromJson(jsonString);

import 'dart:convert';

AttendanceAllModel attendanceAllModelFromJson(String str) => AttendanceAllModel.fromJson(json.decode(str));


class AttendanceAllModel {
    String message;
    List<Datum> data;
    String status;

    AttendanceAllModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory AttendanceAllModel.fromJson(Map<String, dynamic> json) => AttendanceAllModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    String name;
    String attendDate;
    String clockIn;
    String clockOut;
    String workTime;
    String status;
    String attendType;
    String tdate;
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
        attendDate: json["attend_date"],
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        workTime: json["work_time"],
        status: json["status"],
        attendType: json["attend_type"],
        tdate: json["tdate"],
        ttime: json["ttime"],
    );
}

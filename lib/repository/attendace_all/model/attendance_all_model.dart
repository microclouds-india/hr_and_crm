import 'dart:convert';

AttendanceAllModel attendanceAllModelFromJson(String str) => AttendanceAllModel.fromJson(json.decode(str));

class AttendanceAllModel {
    AttendanceAllModel({
        required this.message,
        required this.data,
        required this.status,
    });

    String message;
    List<Datum> data;
    String status;

    factory AttendanceAllModel.fromJson(Map<String, dynamic> json) => AttendanceAllModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
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

    String name;
    DateTime attendDate;
    String clockIn;
    String clockOut;
    String workTime;
    String status;
    String attendType;
    DateTime tdate;
    String ttime;

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
}

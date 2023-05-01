import 'dart:convert';

AttendanceAllModel attendanceAllModelFromJson(String str) => AttendanceAllModel.fromJson(json.decode(str));

class AttendanceAllModel {
    AttendanceAllModel({
         this.message,
         this.data,
         this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory AttendanceAllModel.fromJson(Map<String, dynamic> json) => AttendanceAllModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
         this.name,
         this.attendDate,
         this.clockIn,
         this.clockOut,
         this.workTime,
         this.status,
         this.attendType,
         this.tdate,
         this.ttime,
    });

    String? name;
    DateTime? attendDate;
    String? clockIn;
    String? clockOut;
    String? workTime;
    String? status;
    String? attendType;
    DateTime? tdate;
    String? ttime;

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

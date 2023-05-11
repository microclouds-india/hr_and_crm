
import 'dart:convert';

AttendanceReportModel attendanceReportModelFromJson(String str) => AttendanceReportModel.fromJson(json.decode(str));


class AttendanceReportModel {
    String? message;
    List<Datum>? data;
    String? status;

    AttendanceReportModel({
        this.message,
        this.data,
        this.status,
    });

    factory AttendanceReportModel.fromJson(Map<String, dynamic> json) => AttendanceReportModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

}

class Datum {
    String? id;
    String? name;
    String? attendDate;
    String? clockIn;
    String? clockOut;
    String? workTime;
    String? tdate;
    String? ttime;

    Datum({
        this.id,
        this.name,
        this.attendDate,
        this.clockIn,
        this.clockOut,
        this.workTime,
        this.tdate,
        this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        attendDate: json["attend_date"],
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        workTime: json["work_time"],
        tdate:json["tdate"],
        ttime: json["ttime"],
    );
}

enum Name { MIRSHAD }

final nameValues = EnumValues({
    "mirshad ": Name.MIRSHAD
});

enum WorkTime { THE_0_HOURS, THE_3_HOURS, THE_1_HOURS, EMPTY, THE_4_HOURS }

final workTimeValues = EnumValues({
    "": WorkTime.EMPTY,
    "0 hours": WorkTime.THE_0_HOURS,
    "1 hours": WorkTime.THE_1_HOURS,
    "3 hours": WorkTime.THE_3_HOURS,
    "4 hours": WorkTime.THE_4_HOURS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

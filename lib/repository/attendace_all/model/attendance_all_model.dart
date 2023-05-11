
import 'dart:convert';

AttendanceAllModel attendanceAllModelFromJson(String str) => AttendanceAllModel.fromJson(json.decode(str));


class AttendanceAllModel {
    String? message;
    List<Datum>? data;
    String? status;

    AttendanceAllModel({
        this.message,
        this.data,
        this.status,
    });

    factory AttendanceAllModel.fromJson(Map<String, dynamic> json) => AttendanceAllModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    String? name;
    String? attendDate;
    String? clockIn;
    String? clockOut;
    String? workTime;
    String? status;
    String? attendType;
    DateTime? tdate;
    String? ttime;

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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name:json["name"],
        attendDate:json["attend_date"],
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        workTime: json["work_time"],
        status: json["status"],
        attendType: json["attend_type"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

}

enum Name { MIRSHAD }

final nameValues = EnumValues({
    "mirshad ": Name.MIRSHAD
});

enum WorkTime { EMPTY, THE_4_HOURS, THE_0_HOURS }

final workTimeValues = EnumValues({
    "": WorkTime.EMPTY,
    "0 hours": WorkTime.THE_0_HOURS,
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

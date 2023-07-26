// To parse this JSON data, do
//
//     final clockInViewModel = clockInViewModelFromJson(jsonString);

import 'dart:convert';

ClockInViewModel clockInViewModelFromJson(String str) => ClockInViewModel.fromJson(json.decode(str));

String clockInViewModelToJson(ClockInViewModel data) => json.encode(data.toJson());

class ClockInViewModel {
    String message;
    List<Datum> data;
    String status;

    ClockInViewModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory ClockInViewModel.fromJson(Map<String, dynamic> json) => ClockInViewModel(
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
    String name;
    DateTime attendDate;
    String clockIn;
    String clockOut;
    String workTime;

    Datum({
        required this.id,
        required this.name,
        required this.attendDate,
        required this.clockIn,
        required this.clockOut,
        required this.workTime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        attendDate: DateTime.parse(json["attend_date"]),
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        workTime: json["work_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "attend_date": "${attendDate.year.toString().padLeft(4, '0')}-${attendDate.month.toString().padLeft(2, '0')}-${attendDate.day.toString().padLeft(2, '0')}",
        "clock_in": clockIn,
        "clock_out": clockOut,
        "work_time": workTime,
    };
}

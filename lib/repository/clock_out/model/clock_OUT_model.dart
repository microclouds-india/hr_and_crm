import 'dart:convert';

ClockOutModel clockOutModelFromJson(String str) => ClockOutModel.fromJson(json.decode(str));


class ClockOutModel {
    ClockOutModel({
        required this.message,
        required this.data,
        required this.status,
    });

    String message;
    List<Datum> data;
    String status;

    factory ClockOutModel.fromJson(Map<String, dynamic> json) => ClockOutModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
        required this.id,
        required this.employeeId,
        required this.attendDate,
        required this.clockIn,
        required this.clockOut,
    });

    String id;
    String employeeId;
    DateTime attendDate;
    String clockIn;
    String clockOut;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        employeeId: json["employee_id"],
        attendDate: DateTime.parse(json["attend_date"]),
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "attend_date": "${attendDate.year.toString().padLeft(4, '0')}-${attendDate.month.toString().padLeft(2, '0')}-${attendDate.day.toString().padLeft(2, '0')}",
        "clock_in": clockIn,
        "clock_out": clockOut,
    };
}

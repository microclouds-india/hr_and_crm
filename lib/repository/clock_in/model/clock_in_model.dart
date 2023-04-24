import 'dart:convert';

ClockInModel clockInModelFromJson(String str) => ClockInModel.fromJson(json.decode(str));


class ClockInModel {
    ClockInModel({
        required this.employeeId,
        required this.attendDate,
        required this.clockIn,
        required this.tdate,
        required this.ttime,
        required this.message,
        required this.status,
    });

    String employeeId;
    DateTime attendDate;
    String clockIn;
    DateTime tdate;
    String ttime;
    String message;
    String status;

    factory ClockInModel.fromJson(Map<String, dynamic> json) => ClockInModel(
        employeeId: json["employee_id"],
        attendDate: DateTime.parse(json["attend_date"]),
        clockIn: json["clock_in"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
        message: json["message"],
        status: json["status"],
    );
}

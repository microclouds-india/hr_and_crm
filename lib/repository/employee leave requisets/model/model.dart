// To parse this JSON data, do
//
//     final employeeLeaveRequistesModel = employeeLeaveRequistesModelFromJson(jsonString);

import 'dart:convert';

EmployeeLeaveRequistesModel employeeLeaveRequistesModelFromJson(String str) => EmployeeLeaveRequistesModel.fromJson(json.decode(str));


class EmployeeLeaveRequistesModel {
    String message;
    List<Datum> data;
    String status;

    EmployeeLeaveRequistesModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory EmployeeLeaveRequistesModel.fromJson(Map<String, dynamic> json) => EmployeeLeaveRequistesModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

  
}

class Datum {
    String employeeId;
    String ldate;
    String reason;
    String status;
    DateTime tdate;
    String ttime;

    Datum({
        required this.employeeId,
        required this.ldate,
        required this.reason,
        required this.status,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employeeId: json["employee_id"],
        ldate: json["ldate"],
        reason: json["reason"],
        status:json["status"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

}

enum Status { PENDING, ACCEPTED }

final statusValues = EnumValues({
    "accepted": Status.ACCEPTED,
    "pending": Status.PENDING
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

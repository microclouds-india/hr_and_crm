// To parse this JSON data, do
//
//     final addAbsentModel = addAbsentModelFromJson(jsonString);

import 'dart:convert';

AddAbsentModel addAbsentModelFromJson(String str) => AddAbsentModel.fromJson(json.decode(str));

String addAbsentModelToJson(AddAbsentModel data) => json.encode(data.toJson());

class AddAbsentModel {
    String employeeId;
    DateTime attendDate;
    String status;
    DateTime tdate;
    String ttime;
    String message;

    AddAbsentModel({
        required this.employeeId,
        required this.attendDate,
        required this.status,
        required this.tdate,
        required this.ttime,
        required this.message,
    });

    factory AddAbsentModel.fromJson(Map<String, dynamic> json) => AddAbsentModel(
        employeeId: json["employee_id"],
        attendDate: DateTime.parse(json["attend_date"]),
        status: json["status"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "attend_date": "${attendDate.year.toString().padLeft(4, '0')}-${attendDate.month.toString().padLeft(2, '0')}-${attendDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
        "message": message,
    };
}

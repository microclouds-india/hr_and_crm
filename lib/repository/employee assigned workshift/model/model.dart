// To parse this JSON data, do
//
//     final employeeAssignedWorkShiftModel = employeeAssignedWorkShiftModelFromJson(jsonString);

import 'dart:convert';

EmployeeAssignedWorkShiftModel employeeAssignedWorkShiftModelFromJson(String str) => EmployeeAssignedWorkShiftModel.fromJson(json.decode(str));

String employeeAssignedWorkShiftModelToJson(EmployeeAssignedWorkShiftModel data) => json.encode(data.toJson());

class EmployeeAssignedWorkShiftModel {
    String message;
    List<Datum> data;
    String status;

    EmployeeAssignedWorkShiftModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory EmployeeAssignedWorkShiftModel.fromJson(Map<String, dynamic> json) => EmployeeAssignedWorkShiftModel(
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
    String shift;
    String startTime;
    String endTime;

    Datum({
        required this.id,
        required this.shift,
        required this.startTime,
        required this.endTime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        shift: json["shift"],
        startTime: json["start_time"],
        endTime: json["end_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shift": shift,
        "start_time": startTime,
        "end_time": endTime,
    };
}

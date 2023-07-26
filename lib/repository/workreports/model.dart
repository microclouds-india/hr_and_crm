// To parse this JSON data, do
//
//     final workReportsModel = workReportsModelFromJson(jsonString);

import 'dart:convert';

WorkReportsModel workReportsModelFromJson(String str) => WorkReportsModel.fromJson(json.decode(str));

String workReportsModelToJson(WorkReportsModel data) => json.encode(data.toJson());

class WorkReportsModel {
    String message;
    List<Datum> data;
    String status;

    WorkReportsModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory WorkReportsModel.fromJson(Map<String, dynamic> json) => WorkReportsModel(
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
    String employeeId;
    DateTime reportDate;
    String reportMessage;
    DateTime tdate;
    String ttime;

    Datum({
        required this.id,
        required this.employeeId,
        required this.reportDate,
        required this.reportMessage,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        employeeId: json["employee_id"],
        reportDate: DateTime.parse(json["report_date"]),
        reportMessage: json["report_message"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "report_date": "${reportDate.year.toString().padLeft(4, '0')}-${reportDate.month.toString().padLeft(2, '0')}-${reportDate.day.toString().padLeft(2, '0')}",
        "report_message": reportMessage,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

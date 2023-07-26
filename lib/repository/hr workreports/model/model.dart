// To parse this JSON data, do
//
//     final hrWorkrepoertsModel = hrWorkrepoertsModelFromJson(jsonString);

import 'dart:convert';

HrWorkrepoertsModel hrWorkrepoertsModelFromJson(String str) => HrWorkrepoertsModel.fromJson(json.decode(str));


class HrWorkrepoertsModel {
    String message;
    List<Datum> data;
    String status;

    HrWorkrepoertsModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory HrWorkrepoertsModel.fromJson(Map<String, dynamic> json) => HrWorkrepoertsModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

}

class Datum {
    String id;
    String employeeId;
    String reportDate;
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
        reportDate:json["report_date"],
        reportMessage: json["report_message"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

}

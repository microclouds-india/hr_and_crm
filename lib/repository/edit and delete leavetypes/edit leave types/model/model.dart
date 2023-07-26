// To parse this JSON data, do
//
//     final editLeaveTypesModel = editLeaveTypesModelFromJson(jsonString);

import 'dart:convert';

EditLeaveTypesModel editLeaveTypesModelFromJson(String str) => EditLeaveTypesModel.fromJson(json.decode(str));

String editLeaveTypesModelToJson(EditLeaveTypesModel data) => json.encode(data.toJson());

class EditLeaveTypesModel {
    String message;
    List<Datum> data;
    String status;

    EditLeaveTypesModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory EditLeaveTypesModel.fromJson(Map<String, dynamic> json) => EditLeaveTypesModel(
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
    String leaveType;
    DateTime tdate;
    String ttime;

    Datum({
        required this.id,
        required this.leaveType,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        leaveType: json["leave_type"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "leave_type": leaveType,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

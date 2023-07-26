// To parse this JSON data, do
//
//     final workShiftsModel = workShiftsModelFromJson(jsonString);

import 'dart:convert';

WorkShiftsModel workShiftsModelFromJson(String str) => WorkShiftsModel.fromJson(json.decode(str));

String workShiftsModelToJson(WorkShiftsModel data) => json.encode(data.toJson());

class WorkShiftsModel {
    String message;
    List<Datum> data;
    String status;

    WorkShiftsModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory WorkShiftsModel.fromJson(Map<String, dynamic> json) => WorkShiftsModel(
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
    String branchId;
    String shift;
    String shiftTime;
    DateTime tdate;
    String ttime;

    Datum({
        required this.id,
        required this.branchId,
        required this.shift,
        required this.shiftTime,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        branchId: json["branch_id"],
        shift: json["shift"],
        shiftTime: json["shift_time"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "shift": shift,
        "shift_time": shiftTime,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

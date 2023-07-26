// To parse this JSON data, do
//
//     final jobRolesModel = jobRolesModelFromJson(jsonString);

import 'dart:convert';

JobRolesModel jobRolesModelFromJson(String str) => JobRolesModel.fromJson(json.decode(str));

String jobRolesModelToJson(JobRolesModel data) => json.encode(data.toJson());

class JobRolesModel {
    String message;
    List<Datum> data;
    String status;

    JobRolesModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory JobRolesModel.fromJson(Map<String, dynamic> json) => JobRolesModel(
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
    String companyId;
    String jobrole;
    String tdate;
    String ttime;

    Datum({
        required this.id,
        required this.companyId,
        required this.jobrole,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companyId: json["company_id"],
        jobrole: json["jobrole"],
        tdate: json["tdate"],
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "jobrole": jobrole,
        "tdate": tdate,
        "ttime": ttime,
    };
}

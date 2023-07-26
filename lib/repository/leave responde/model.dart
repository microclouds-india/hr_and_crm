// To parse this JSON data, do
//
//     final leaveRespondeModel = leaveRespondeModelFromJson(jsonString);

import 'dart:convert';

LeaveRespondeModel leaveRespondeModelFromJson(String str) => LeaveRespondeModel.fromJson(json.decode(str));

String leaveRespondeModelToJson(LeaveRespondeModel data) => json.encode(data.toJson());

class LeaveRespondeModel {
    String message;
    List<Datum> data;
    String status;

    LeaveRespondeModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory LeaveRespondeModel.fromJson(Map<String, dynamic> json) => LeaveRespondeModel(
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
    String status;
    String comment;

    Datum({
        required this.id,
        required this.status,
        required this.comment,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        status: json["status"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "comment": comment,
    };
}

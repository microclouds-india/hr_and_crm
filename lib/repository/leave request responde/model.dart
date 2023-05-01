import 'dart:convert';

LeaveRequestRespondModel leaveRequestRespondFromJson(String str) =>
    LeaveRequestRespondModel.fromJson(json.decode(str));


class LeaveRequestRespondModel {
  String? message;
  List<Datum>? data;
  String? status;

  LeaveRequestRespondModel({
     this.message,
     this.data,
     this.status,
  });

  factory LeaveRequestRespondModel.fromJson(Map<String, dynamic> json) =>
      LeaveRequestRespondModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
      );
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
}

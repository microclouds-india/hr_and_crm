// To parse this JSON data, do
//
//     final branchesModel = branchesModelFromJson(jsonString);

import 'dart:convert';

BranchesModel branchesModelFromJson(String str) => BranchesModel.fromJson(json.decode(str));

String branchesModelToJson(BranchesModel data) => json.encode(data.toJson());

class BranchesModel {
  BranchesModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory BranchesModel.fromJson(Map<String, dynamic> json) => BranchesModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))  ?? []),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.branchName,
    required this.address,
    required this.tdate,
    required this.ttime,
  });

  String id;
  String branchName;
  String address;
  String tdate;
  String ttime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    branchName: json["branch_name"] ?? "",
    address: json["address"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch_name": branchName,
    "address": address,
    "tdate": tdate,
    "ttime": ttime,
  };
}

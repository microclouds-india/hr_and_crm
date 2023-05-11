import 'dart:convert';

AddBranchModel addBranchModelFromJson(String str) => AddBranchModel.fromJson(json.decode(str));

String addBranchModelToJson(AddBranchModel data) => json.encode(data.toJson());

class AddBranchModel {
    String branchName;
    String address;
    DateTime tdate;
    String ttime;
    String message;
    String status;

    AddBranchModel({
        required this.branchName,
        required this.address,
        required this.tdate,
        required this.ttime,
        required this.message,
        required this.status,
    });

    factory AddBranchModel.fromJson(Map<String, dynamic> json) => AddBranchModel(
        branchName: json["branch_name"],
        address: json["address"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "branch_name": branchName,
        "address": address,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
        "message": message,
        "status": status,
    };
}

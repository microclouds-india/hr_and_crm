// To parse this JSON data, do
//
//     final expenseCategoryModel = expenseCategoryModelFromJson(jsonString);

import 'dart:convert';

ExpenseCategoryModel expenseCategoryModelFromJson(String str) => ExpenseCategoryModel.fromJson(json.decode(str));

String expenseCategoryModelToJson(ExpenseCategoryModel data) => json.encode(data.toJson());

class ExpenseCategoryModel {
    String message;
    List<Datum> data;
    String status;

    ExpenseCategoryModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) => ExpenseCategoryModel(
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
    String expCategory;
    String companyId;
    DateTime tdate;
    String ttime;

    Datum({
        required this.id,
        required this.expCategory,
        required this.companyId,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        expCategory: json["exp_category"],
        companyId: json["company_id"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "exp_category": expCategory,
        "company_id": companyId,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

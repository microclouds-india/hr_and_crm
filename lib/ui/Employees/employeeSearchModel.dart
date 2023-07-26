// To parse this JSON data, do
//
//     final employeeSearchModel = employeeSearchModelFromJson(jsonString);

import 'dart:convert';

EmployeeSearchModel employeeSearchModelFromJson(String str) => EmployeeSearchModel.fromJson(json.decode(str));

String employeeSearchModelToJson(EmployeeSearchModel data) => json.encode(data.toJson());

class EmployeeSearchModel {
    String message;
    List<Datum> data;
    String status;

    EmployeeSearchModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory EmployeeSearchModel.fromJson(Map<String, dynamic> json) => EmployeeSearchModel(
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
    String name;
    String dob;
    String phone;
    String city;
    String email;
    String address;
    String jobrole;
    String gender;
    String photo;
    String tdate;
    String ttime;

    Datum({
        required this.id,
        required this.companyId,
        required this.name,
        required this.dob,
        required this.phone,
        required this.city,
        required this.email,
        required this.address,
        required this.jobrole,
        required this.gender,
        required this.photo,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        dob: json["dob"],
        phone: json["phone"],
        city: json["city"],
        email: json["email"],
        address: json["address"],
        jobrole: json["jobrole"],
        gender: json["gender"],
        photo: json["photo"],
        tdate: json["tdate"],
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "dob": dob,
        "phone": phone,
        "city": city,
        "email": email,
        "address": address,
        "jobrole": jobrole,
        "gender": gender,
        "photo": photo,
        "tdate": tdate,
        "ttime": ttime,
    };
}

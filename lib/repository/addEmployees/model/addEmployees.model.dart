// To parse this JSON data, do
//
//     final addEmployeesModel = addEmployeesModelFromJson(jsonString);

import 'dart:convert';

AddEmployeesModel addEmployeesModelFromJson(String str) => AddEmployeesModel.fromJson(json.decode(str));

String addEmployeesModelToJson(AddEmployeesModel data) => json.encode(data.toJson());

class AddEmployeesModel {
  AddEmployeesModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.dob,
    required this.city,
    required this.address,
    required this.gender,
    required this.countryCode,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String name;
  String phone;
  String email;
  String dob;
  String city;
  String address;
  String gender;
  String countryCode;
  String tdate;
  String ttime;
  String message;
  String status;

  factory AddEmployeesModel.fromJson(Map<String, dynamic> json) => AddEmployeesModel(
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    email: json["email"] ?? "",
    dob: json["dob"] ?? "",
    city: json["city"] ?? "",
    address: json["address"] ?? "",
    gender: json["gender"] ?? "",
    countryCode: json["country_code"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
    message: json["message"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
    "dob": dob,
    "city": city,
    "address": address,
    "gender": gender,
    "country_code": countryCode,
    "tdate": tdate,
    "ttime": ttime,
    "message": message,
    "status": status,
  };
}

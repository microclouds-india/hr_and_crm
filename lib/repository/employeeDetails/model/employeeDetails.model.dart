// To parse this JSON data, do
//
//     final employeeDetailsModel = employeeDetailsModelFromJson(jsonString);

import 'dart:convert';

EmployeeDetailsModel employeeDetailsModelFromJson(String str) => EmployeeDetailsModel.fromJson(json.decode(str));

String employeeDetailsModelToJson(EmployeeDetailsModel data) => json.encode(data.toJson());

class EmployeeDetailsModel {
  EmployeeDetailsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) => EmployeeDetailsModel(
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
  Datum({
    required this.name,
    required this.dob,
    required this.phone,
    required this.city,
    required this.email,
    required this.address,
    required this.gender,
    required this.photo,
    required this.tdate,
    required this.ttime,
  });

  String name;
  String dob;
  String phone;
  String city;
  String email;
  String address;
  String gender;
  String photo;
  DateTime tdate;
  String ttime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    dob: json["dob"],
    phone: json["phone"],
    city: json["city"],
    email: json["email"],
    address: json["address"],
    gender: json["gender"],
    photo: json["photo"],
    tdate: DateTime.parse(json["tdate"]),
    ttime: json["ttime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dob": dob,
    "phone": phone,
    "city": city,
    "email": email,
    "address": address,
    "gender": gender,
    "photo": photo,
    "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
    "ttime": ttime,
  };
}

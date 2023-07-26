// To parse this JSON data, do
//
//     final employeeViewModel = employeeViewModelFromJson(jsonString);

import 'dart:convert';

EmployeeViewModel employeeViewModelFromJson(String str) => EmployeeViewModel.fromJson(json.decode(str));

String employeeViewModelToJson(EmployeeViewModel data) => json.encode(data.toJson());

class EmployeeViewModel {
    String message;
    List<Datum> data;
    String status;

    EmployeeViewModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory EmployeeViewModel.fromJson(Map<String, dynamic> json) => EmployeeViewModel(
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
    String name;
    String dob;
    String phone;
    String city;
    String email;
    String address;
    String gender;
    String photo;
    String jobrole;
    String tdate;
    String ttime;

    Datum({
        required this.name,
        required this.dob,
        required this.phone,
        required this.city,
        required this.email,
        required this.address,
        required this.gender,
        required this.photo,
        required this.jobrole,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        dob: json["dob"],
        phone: json["phone"],
        city: json["city"],
        email: json["email"],
        address: json["address"],
        gender: json["gender"],
        photo: json["photo"],
        jobrole: json["jobrole"],
        tdate: json["tdate"],
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
        "jobrole": jobrole,
        "tdate": tdate,
        "ttime": ttime,
    };
}

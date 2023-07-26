// To parse this JSON data, do
//
//     final profileViewMode = profileViewModeFromJson(jsonString);

import 'dart:convert';

ProfileViewMode profileViewModeFromJson(String str) => ProfileViewMode.fromJson(json.decode(str));

String profileViewModeToJson(ProfileViewMode data) => json.encode(data.toJson());

class ProfileViewMode {
    String message;
    List<Datum> data;
    String status;

    ProfileViewMode({
        required this.message,
        required this.data,
        required this.status,
    });

    factory ProfileViewMode.fromJson(Map<String, dynamic> json) => ProfileViewMode(
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
    String name;
    String dob;
    String phone;
    String city;
    String email;
    String address;
    String jobrole;
    String gender;
    String photo;

    Datum({
        required this.id,
        required this.name,
        required this.dob,
        required this.phone,
        required this.city,
        required this.email,
        required this.address,
        required this.jobrole,
        required this.gender,
        required this.photo,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        dob: json["dob"],
        phone: json["phone"],
        city: json["city"],
        email: json["email"],
        address: json["address"],
        jobrole: json["jobrole"],
        gender: json["gender"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dob": dob,
        "phone": phone,
        "city": city,
        "email": email,
        "address": address,
        "jobrole": jobrole,
        "gender": gender,
        "photo": photo,
    };
}

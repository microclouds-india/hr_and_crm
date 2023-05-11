// To parse this JSON data, do
//
//     final profileViewMode = profileViewModeFromJson(jsonString);

import 'dart:convert';

ProfileViewMode profileViewModeFromJson(String str) => ProfileViewMode.fromJson(json.decode(str));


class ProfileViewMode {
    String? message;
    List<Datum>? data;
    String? status;

    ProfileViewMode({
        this.message,
        this.data,
        this.status,
    });

    factory ProfileViewMode.fromJson(Map<String, dynamic> json) => ProfileViewMode(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    String? id;
    String? name;
    String? dob;
    String? phone;
    String? city;
    String? email;
    String? address;
    String? jobrole;
    String? gender;
    String? photo;

    Datum({
        this.id,
        this.name,
        this.dob,
        this.phone,
        this.city,
        this.email,
        this.address,
        this.jobrole,
        this.gender,
        this.photo,
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

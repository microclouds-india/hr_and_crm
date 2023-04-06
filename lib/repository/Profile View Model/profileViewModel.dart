// To parse this JSON data, do
//
//     final profileViewMode = profileViewModeFromJson(jsonString);

import 'dart:convert';

ProfileViewMode profileViewModeFromJson(String str) => ProfileViewMode.fromJson(json.decode(str));


class ProfileViewMode {
    ProfileViewMode({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory ProfileViewMode.fromJson(Map<String, dynamic> json) => ProfileViewMode(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.phone,
        this.email,
    });

    String? id;
    String? name;
    String? phone;
    String? email;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
    );
}

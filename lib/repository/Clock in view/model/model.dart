import 'dart:convert';

ClockinviewModel clockinviewFromJson(String str) => ClockinviewModel.fromJson(json.decode(str));

String clockinviewToJson(ClockinviewModel data) => json.encode(data.toJson());

class ClockinviewModel {
    String message;
    List<Datum> data;
    String status;

    ClockinviewModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory ClockinviewModel.fromJson(Map<String, dynamic> json) => ClockinviewModel(
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
    DateTime attendDate;
    String clockIn;

    Datum({
        required this.id,
        required this.name,
        required this.attendDate,
        required this.clockIn,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        attendDate: DateTime.parse(json["attend_date"]),
        clockIn: json["clock_in"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "attend_date": "${attendDate.year.toString().padLeft(4, '0')}-${attendDate.month.toString().padLeft(2, '0')}-${attendDate.day.toString().padLeft(2, '0')}",
        "clock_in": clockIn,
    };
}

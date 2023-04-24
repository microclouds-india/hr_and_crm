import 'dart:convert';

AddHolidayModel addHolidayModelFromJson(String str) => AddHolidayModel.fromJson(json.decode(str));


class AddHolidayModel {
    AddHolidayModel({
        required this.year,
        required this.holidayDate,
        required this.title,
        required this.tdate,
        required this.ttime,
        required this.message,
        required this.status,
    });

    String year;
    String holidayDate;
    String title;
    DateTime tdate;
    String ttime;
    String message;
    String status;

    factory AddHolidayModel.fromJson(Map<String, dynamic> json) => AddHolidayModel(
        year: json["year"],
        holidayDate: json["holiday_date"],
        title: json["title"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
        message: json["message"],
        status: json["status"],
    );
}

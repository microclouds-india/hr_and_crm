import 'dart:convert';

LeaveRequestModel leaveRequestModelFromJson(String str) => LeaveRequestModel.fromJson(json.decode(str));


class LeaveRequestModel {
    LeaveRequestModel({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory LeaveRequestModel.fromJson(Map<String, dynamic> json) => LeaveRequestModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
        this.employeeId,
        this.ldate,
        this.reason,
        this.tdate,
        this.ttime,
    });

    String? employeeId;
    String? ldate;
    String? reason;
    DateTime? tdate;
    String? ttime;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employeeId: json["employee_id"],
        ldate: json["ldate"],
        reason: json["reason"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

}

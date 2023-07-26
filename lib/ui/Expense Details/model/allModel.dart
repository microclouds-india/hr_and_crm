// To parse this JSON data, do
//
//     final employeeExpenseModelAll = employeeExpenseModelAllFromJson(jsonString);

import 'dart:convert';

EmployeeExpenseModelAll employeeExpenseModelAllFromJson(String str) => EmployeeExpenseModelAll.fromJson(json.decode(str));

String employeeExpenseModelAllToJson(EmployeeExpenseModelAll data) => json.encode(data.toJson());

class EmployeeExpenseModelAll {
    String message;
    List<Datum> data;
    String status;

    EmployeeExpenseModelAll({
        required this.message,
        required this.data,
        required this.status,
    });

    factory EmployeeExpenseModelAll.fromJson(Map<String, dynamic> json) => EmployeeExpenseModelAll(
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
    EmployeeName employeeName;
    String employeeId;
    String expDate;
    String expType;
    String expAmount;
    DateTime tdate;
    String ttime;

    Datum({
        required this.employeeName,
        required this.employeeId,
        required this.expDate,
        required this.expType,
        required this.expAmount,
        required this.tdate,
        required this.ttime,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employeeName: employeeNameValues.map[json["employee_name"]]!,
        employeeId: json["employee_id"],
        expDate: json["exp_date"],
        expType: json["exp_type"],
        expAmount: json["exp_amount"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "employee_name": employeeNameValues.reverse[employeeName],
        "employee_id": employeeId,
        "exp_date": expDate,
        "exp_type": expType,
        "exp_amount": expAmount,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

enum EmployeeName { T55555, EMPTY }

final employeeNameValues = EnumValues({
    "": EmployeeName.EMPTY,
    "t55555": EmployeeName.T55555
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

// To parse this JSON data, do
//
//     final employeeExpenseViewModel = employeeExpenseViewModelFromJson(jsonString);

import 'dart:convert';

EmployeeExpenseViewModel employeeExpenseViewModelFromJson(String str) => EmployeeExpenseViewModel.fromJson(json.decode(str));

String employeeExpenseViewModelToJson(EmployeeExpenseViewModel data) => json.encode(data.toJson());

class EmployeeExpenseViewModel {
    String message;
    List<Datum> data;
    String status;

    EmployeeExpenseViewModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory EmployeeExpenseViewModel.fromJson(Map<String, dynamic> json) => EmployeeExpenseViewModel(
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
    String employeeName;
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
        employeeName: json["employee_name"],
        employeeId: json["employee_id"],
        expDate: json["exp_date"],
        expType: json["exp_type"],
        expAmount: json["exp_amount"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
    );

    Map<String, dynamic> toJson() => {
        "employee_name": employeeName,
        "employee_id": employeeId,
        "exp_date": expDate,
        "exp_type": expType,
        "exp_amount": expAmount,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
    };
}

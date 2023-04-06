import 'dart:convert';

EmployeesViewModel employeesViewModelFromJson(String str) => EmployeesViewModel.fromJson(json.decode(str));


class EmployeesViewModel {
    EmployeesViewModel({
        this.message,
        this.data,
        this.status,
    });

    String? message;
    List<Datum>? data;
    String? status;

    factory EmployeesViewModel.fromJson(Map<String, dynamic> json) => EmployeesViewModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );
}

class Datum {
    Datum({
        this.name,
        this.dob,
        this.phone,
        this.city,
        this.email,
        this.address,
        this.gender,
        this.photo,
        this.tdate,
        this.ttime,
    });

    String? name;
    String? dob;
    String? phone;
    String? city;
    String? email;
    String? address;
    String? gender;
    String? photo;
    DateTime? tdate;
    String? ttime;

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
}

class EmployeesModel {
  EmployeesModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory EmployeesModel.fromJson(Map<String, dynamic> json) => EmployeesModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.dob,
    required this.phone,
    required this.city,
    required this.email,
    required this.address,
    required this.gender,
    required this.photo,
    required this.tdate,
    required this.ttime,
  });

  String id;
  String name;
  String dob;
  String phone;
  String city;
  String email;
  String address;
  String gender;
  String photo;
  String tdate;
  String ttime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    dob: json["dob"] ?? "",
    phone: json["phone"] ?? "",
    city: json["city"] ?? "",
    email: json["email"] ?? "",
    address: json["address"] ?? "",
    gender: json["gender"] ?? "",
    photo: json["photo"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dob": dob,
    "phone": phone,
    "city": city,
    "email": email,
    "address": address,
    "gender": gender,
    "photo": photo,
    "tdate": tdate,
    "ttime": ttime,
  };
}

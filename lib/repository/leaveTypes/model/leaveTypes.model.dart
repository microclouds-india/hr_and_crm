class LeavetypesModel {
  LeavetypesModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory LeavetypesModel.fromJson(Map<String, dynamic> json) => LeavetypesModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)) ?? []),
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
    required this.leaveType,
    required this.tdate,
    required this.ttime,
  });

  String id;
  String leaveType;
  String tdate;
  String ttime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    leaveType: json["leave_type"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leave_type": leaveType,
    "tdate": tdate,
    "ttime": ttime,
  };
}

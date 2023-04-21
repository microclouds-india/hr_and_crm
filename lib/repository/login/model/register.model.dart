class RegisterModel {
  RegisterModel({
    required this.status,
    required this.response,
    required this.user,
    required this.smsResponse,
  });

  String status;
  String response;
  String user;
  String smsResponse;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"] ?? "",
    response: json["response"] ?? "",
    user: json["user"] ?? "",
    smsResponse: json["sms_response"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response": response,
    "user": user,
    "sms_response": smsResponse,
  };
}

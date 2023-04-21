class OtpModel {
  OtpModel({
    required this.status,
    required this.response,
    required this.token,
    required this.userSignup,
  });

  String status;
  String response;
  String token;
  String userSignup;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    status: json["status"] ?? "",
    response: json["response"] ?? "",
    token: json["token"] ?? "",
    userSignup: json["user_signup"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response": response,
    "token": token,
    "user_signup": userSignup,
  };
}

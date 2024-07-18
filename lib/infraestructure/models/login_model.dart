import 'dart:convert';

class LoginModelResponse {
  final Data data;

  LoginModelResponse({required this.data});

  factory LoginModelResponse.fromJson(Map<String, dynamic> json) => LoginModelResponse.fromMap(json);

  String toJson() => json.encode(toMap());

  factory LoginModelResponse.fromMap(Map<String, dynamic> json) => LoginModelResponse(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  final String tk;

  Data({required this.tk});

  factory Data.fromJson(Map<String, dynamic> json) => Data.fromMap(json);

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        tk: json["tk"],
      );

  Map<String, dynamic> toMap() => {
        "tk": tk,
      };
}

import 'dart:convert';

//nuevo login model response esto nos brinda token de seguridad para as demas peticiones

class LoginModelResponse {
  LoginModelResponse({
    required this.data,
  });

  Data data;

  factory LoginModelResponse.fromJson(String str) => LoginModelResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModelResponse.fromMap(Map<String, dynamic> json) => LoginModelResponse(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.tk,
  });

  String tk;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        tk: json["tk"],
      );

  Map<String, dynamic> toMap() => {
        "tk": tk,
      };
}

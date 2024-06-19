import 'dart:convert';

class UserModelResponse {
  UserModelResponse({
    required this.user,
  });

  UserWithTokenModel user;

  factory UserModelResponse.fromJson(String str) => UserModelResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModelResponse.fromMap(Map<String, dynamic> json) => UserModelResponse(
        user: UserWithTokenModel.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": user.toMap(),
      };
}

class UserWithTokenModel {
  UserWithTokenModel({
    this.sub,
    this.personaid,
    this.tienda,
    this.mobileid,
    this.persona,
    this.correo,
    this.numerodocumento,
    this.celular,
  });

  String? sub;
  int? personaid;
  String? tienda;
  String? mobileid;
  String? persona;
  String? correo;
  String? numerodocumento;
  String? celular;

  factory UserWithTokenModel.fromJson(String str) => UserWithTokenModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserWithTokenModel.fromMap(Map<String, dynamic> json) => UserWithTokenModel(
        sub: json["sub"],
        personaid: json["personaid"],
        tienda: json["tienda"],
        mobileid: json["mobileid"],
        persona: json["persona"],
        correo: json["correo"],
        numerodocumento: json["numerodocumento"],
        celular: json["celular"],
      );

  Map<String, dynamic> toMap() => {
        "sub": sub,
        "personaid": personaid,
        "tienda": tienda,
        "mobileid": mobileid,
        "persona": persona,
        "correo": correo,
        "numerodocumento": numerodocumento,
        "celular": celular,
      };
}

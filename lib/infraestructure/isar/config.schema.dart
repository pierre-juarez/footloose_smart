import 'package:isar/isar.dart';

part 'config.schema.g.dart';

@collection
class Configuration {
  Id id = Isar.autoIncrement;

  int? idConfig;
  String? clave;
  String? valor;
  String? ambiente;
  String? typeRequest;
  int? idOption;

  Configuration();
  // Método para crear un Client a partir de un Map
  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration()
      ..idConfig = json['idConfig']
      ..clave = json['clave']
      ..valor = json['valor']
      ..ambiente = json['ambiente']
      ..typeRequest = json['type_request']
      ..idOption = json['idCliente'];
  }

  // Método para convertir un Client a un Map
  Map<String, dynamic> toJson() {
    return {
      'idConfig': idConfig,
      'clave': clave,
      'valor': valor,
      'ambiente': ambiente,
      'type_request': typeRequest,
      'idCliente': idOption,
    };
  }

  // {
  //   "idConfig": 1,
  //   "clave": "URL API LOGINx",
  //   "valor": "https://apicomercialdev.sisconti.com/api/v1/producto/obtener",
  //   "ambiente": "PROD",
  //   "type_request": "GET",
  //   "created_at": "2024-07-15T14:44:34.000Z",
  //   "updated_at": "2024-06-27T20:53:16.407Z",
  //   "idCliente": 1
  // }
}

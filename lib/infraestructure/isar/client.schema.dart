import 'package:isar/isar.dart';
part 'client.schema.g.dart';

@collection
class Client {
  Id id = Isar.autoIncrement;

  String? name;
  int? idCliente;

  Client();

  // Método para crear un Client a partir de un Map
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client()
      ..name = json['cliente']
      ..idCliente = json['id'];
  }

  // Método para convertir un Client a un Map
  Map<String, dynamic> toJson() {
    return {
      'cliente': name,
      'id': idCliente,
    };
  }
}

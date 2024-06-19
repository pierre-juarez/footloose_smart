import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

Future<String> getErrorJSON(String key) async {
  final Logger logger = Logger('MyApp');

  try {
    // Lee el contenido del archivo JSON
    String jsonString = await rootBundle.loadString('lib/config/helpers/errors.json');

    // Parsea la cadena JSON en un mapa
    Map<String, dynamic> errorsMap = json.decode(jsonString);

    // Retorna el mensaje de error correspondiente a la clave proporcionada
    return errorsMap[key] ?? 'Ocurrió un error al obtener el error';
  } catch (e) {
    // Maneja cualquier error durante la lectura o análisis del JSON
    logger.warning(e);
    print("🚀 ~ file: get_errors.dart ~ line: 20 ~ TM_FUNCTION: $e");
    return 'Ocurrió un error en la aplicación.';
  }
}

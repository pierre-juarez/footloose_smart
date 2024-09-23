import 'dart:convert';
import 'package:flutter/services.dart';

Future<String> getErrorJSON(String key) async {
  try {
    String jsonString = await rootBundle.loadString('lib/config/helpers/errors.json');
    Map<String, dynamic> errorsMap = json.decode(jsonString);
    return errorsMap[key] ?? 'Ocurrió un error al obtener el error';
  } catch (e) {
    return 'Ocurrió un error en la aplicación. - E: $e';
  }
}

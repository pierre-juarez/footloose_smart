import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/infraestructure/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  Dio dio = Dio();
  late ProductModel product = ProductModel();
  int _statusGetProduct = 0;

  int get statusGetProduct => _statusGetProduct;
  set statusGetProduct(int user) {
    _statusGetProduct = user;
    notifyListeners();
  }

  Future<ProductDetailModel> getProduct(String sku, String urlParam, String typeRequest) async {
    try {
      if (sku == "18805057204") {
        var data = {
          "status": true,
          "data": [
            {
              "producto": sku,
              "nombre": "DAUSITO MÁZ NAH 1304 (38-44) - H CUERO NOBUCK AZUL-40.0",
              "PRECIOCOSTO_siva": 57.89,
              "PRECIOBANCO_civa": 79.00,
              "fechacompra": "2023-09-30T00:00:00.000Z",
              "fechaing": "2023-10-14T00:00:00.000Z",
              "fechaIngCD": "",
              "fechaIngTD": "",
              "proveedor": "INVERSIONES RUBINS S.A.C",
              "PROCEDENCIA": "",
              "TALLAS": "40",
              "MATERIAL 1": 14957,
              "PRESENTACION ACCESORIO": null,
              "DETALLE ARTICULO": "ZAPATOS",
              "MODELO": "1304 (38-44)",
              "COLOR 1": 14976,
              "CATEGORIA": "HOMBRES",
              "COLOR FORRO": "AZUL",
              "TIPO CONSTRUCCION": "CORRIDA",
              "CATEGORIA WEB": "HOMBRES",
              "GENERO WEB": "FEMENINO",
              "COLOR PLANTILLA": "GRIS",
              "ALTURA CANA": "",
              "ACABADO CAPELLADA": "",
              "USO": "FLAT",
              "MATERIAL FORRO": "BADANA",
              "ESTILO TACO": "",
              "DETALLE PLANTA": "FLAT",
              "UNIDAD DE MEDIDA": null,
              "MATERIAL 2": 0,
              "MATERIAL 3": 0,
              "GRUPO DE ARTICULOS": "CALZADOS",
              "TIPO DE ARTICULO": "ZAPATOS",
              "MARCA": "DAUSS",
              "COLOR 2": 0,
              "MATERIAL HUELLA": "",
              "MATERIAL PLANTILLA": "SINTETICO",
              "CONSTRUCCION": "CEMENTADO",
              "TIPO HORMA": "REGULAR",
              "GENERO": "MASCULINO",
              "ESTILO WEB": "CASUAL",
              "OCASION": "CASUAL",
              "ESTILO PUNTA": "CUADRADA",
              "COLOR PLANTA": "BEIGE",
              "LINEA": "",
              "TEMPORADA": "INVIERNO 2022",
              "TIPO HUELLA": "ANTIDESLIZANTE",
              "MATERIAL PLANTA": "TR",
              "COLOR 3": 0,
              "urlimagen": "https://assets.footloose.pe/sip/_images/1x/197_100333_00010002_928_1_014_001.jpg"
            }
          ],
          "message": "Datos obtenidos correctamente"
        };

        return ProductDetailModel.fromJson(data);
      } else {
        var data = {
          "status": true,
          "data": [
            {
              "producto": "1",
              "nombre": "DAUSS 1304 (38-44) - H CUERO NOBUCK AZUL-40.0",
              "PRECIOCOSTO_siva": 57.89,
              "PRECIOBANCO_civa": 79.00,
              "fechacompra": "2023-09-30T00:00:00.000Z",
              "fechaing": "2023-10-14T00:00:00.000Z",
              "fechaIngCD": "",
              "fechaIngTD": "",
              "proveedor": "INVERSIONES RUBINS S.A.C",
              "PROCEDENCIA": "",
              "TALLAS": "40",
              "MATERIAL 1": 14957,
              "PRESENTACION ACCESORIO": null,
              "DETALLE ARTICULO": "ZAPATOS",
              "MODELO": "1304 (38-44)",
              "COLOR 1": 14976,
              "CATEGORIA": "HOMBRES",
              "COLOR FORRO": "AZUL",
              "TIPO CONSTRUCCION": "CORRIDA",
              "CATEGORIA WEB": "HOMBRES",
              "GENERO WEB": "FEMENINO",
              "COLOR PLANTILLA": "GRIS",
              "ALTURA CANA": "",
              "ACABADO CAPELLADA": "",
              "USO": "FLAT",
              "MATERIAL FORRO": "BADANA",
              "ESTILO TACO": "",
              "DETALLE PLANTA": "FLAT",
              "UNIDAD DE MEDIDA": null,
              "MATERIAL 2": 0,
              "MATERIAL 3": 0,
              "GRUPO DE ARTICULOS": "CALZADOS",
              "TIPO DE ARTICULO": "ZAPATOS",
              "MARCA": "DAUSS",
              "COLOR 2": 0,
              "MATERIAL HUELLA": "",
              "MATERIAL PLANTILLA": "SINTETICO",
              "CONSTRUCCION": "CEMENTADO",
              "TIPO HORMA": "REGULAR",
              "GENERO": "MASCULINO",
              "ESTILO WEB": "CASUAL",
              "OCASION": "CASUAL",
              "ESTILO PUNTA": "CUADRADA",
              "COLOR PLANTA": "BEIGE",
              "LINEA": "",
              "TEMPORADA": "INVIERNO 2022",
              "TIPO HUELLA": "ANTIDESLIZANTE",
              "MATERIAL PLANTA": "TR",
              "COLOR 3": 0,
              "urlimagen": "https://assets.footloose.pe/sip/_images/1x/197_100333_00010002_928_1_014_001.jpg"
            }
          ],
          "message": "Datos obtenidos correctamente"
        };

        return ProductDetailModel.fromJson(data);
      }

      Options options = Options(method: typeRequest);

      final String url = "$urlParam/$sku";

      Response resp = await dio.request(url, options: options).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          return Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 408,
            statusMessage: "Error",
          );
        },
      );

      _statusGetProduct = resp.statusCode ?? 400;

      if (resp.statusCode == 200) {
        return ProductDetailModel.fromJson(resp.data);
      } else {
        return ProductDetailModel();
      }
    } catch (e) {
      errorLog(e.toString());
      _statusGetProduct = 404;
      return ProductDetailModel();
    }
  }
}

final productProvider = ChangeNotifierProvider((ref) => ProductProvider());

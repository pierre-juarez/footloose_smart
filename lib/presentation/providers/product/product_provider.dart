import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/constants/environment.dart';
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

  Future<ProductModel> getProduct(String sku) async {
    try {
      Options options = Options(
        method: "GET",
        headers: {
          "Authorization": "Bearer ${Environment.tokenSISCONTI}",
          "Content-Type": "application/json",
        },
      );

      final data = {
        "sku": [sku]
      };

      const url = "https://apicomercialdev.sisconti.com/api/v1/producto/obtener";
      Response resp = await dio.request(url, options: options, data: jsonEncode(data)).timeout(
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
        return ProductModel.fromJson(resp.data);
      } else {
        return ProductModel();
      }
    } catch (e) {
      print("🚀 ~ Error al obtener el producto: $e");
      _statusGetProduct = 404;
      return ProductModel();
    }
  }
}

final productProvider = ChangeNotifierProvider((ref) => ProductProvider());

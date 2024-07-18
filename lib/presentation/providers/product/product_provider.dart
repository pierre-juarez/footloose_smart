import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      print("🚀 ~ Error al obtener el producto: $e");
      _statusGetProduct = 404;
      return ProductDetailModel();
    }
  }
}

final productProvider = ChangeNotifierProvider((ref) => ProductProvider());

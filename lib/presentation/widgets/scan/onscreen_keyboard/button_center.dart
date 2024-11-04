import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/convert_data_product.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/product_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/sku_search_provider.dart';
import 'package:footloose_tickets/presentation/widgets/scan/modal_searching_product.dart';

class ButtonCenter extends ConsumerStatefulWidget {
  const ButtonCenter({
    super.key,
    required this.urlScan,
    required this.typeRequest,
  });

  final String urlScan;
  final String typeRequest;

  @override
  ButtonCenterState createState() => ButtonCenterState();
}

class ButtonCenterState extends ConsumerState<ButtonCenter> {
  bool _isLoadingData = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skuSearch = ref.watch(skuSearchProvider);
    final skuSearchMethods = ref.read(skuSearchProvider.notifier);

    Color colorButton = ((skuSearch.length >= 11 && !_isLoadingData))
        ? const Color.fromARGB(171, 245, 50, 63).withOpacity(1)
        : Colors.grey.withOpacity(0.40);

    void handleError(BuildContext context, String error) async {
      await showError(
        context,
        errorMessage: error.replaceAll("Exception: ", ""),
        title: "Error",
      );
    }

    Future<void> consultProducts() async {
      if (skuSearchMethods.getSkuSearch().length < 11 || _isLoadingData) {
        return;
      }
      setState(() {
        _isLoadingData = true;
      });

      try {
        final listUpd = ref.watch(listProductProvider)['products'] ?? [];
        final product = ref.watch(productProvider);

        if (skuSearch.isNotEmpty) {
          if (!context.mounted) return;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const PopScope(
              canPop: false,
              child: ModalProcessProduct(message: "Obteniendo información del producto..."),
            ),
          );

          if (listUpd.isNotEmpty) {
            bool exists = listUpd.any((p) => p.sku == skuSearch);
            if (exists) {
              throw Exception("El producto ya ha sido agregado a la fila");
            }
          }

          ProductDetailModel productDetail = await product.getProduct(skuSearch, widget.urlScan, widget.typeRequest);

          if (productDetail.productDetail == null) {
            throw Exception("Error al obtener detalle del producto, inténtalo nuevamente");
          }
          if (!context.mounted) return;
          Navigator.pop(context);

          final etiqueta = await convertDataProduct(productDetail, context, ref);
          final etiquetaJson = jsonEncode(etiqueta.toJson());
          // TODO - Activar back después de pushear vista
          appRouter.go(
            '/product?etiqueta=$etiquetaJson',
            // extra: {'replace': true}
          );
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);
        handleError(context, e.toString());
      } finally {
        skuSearchMethods.resetSkuSearch();
        setState(() {
          _isLoadingData = false;
        });
      }
    }

    return InkWell(
      onTap: () async => await consultProducts(),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 26, bottom: 10),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(color: colorButton, borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Text(
            (_isLoadingData) ? "Consultando Producto..." : "Consultar Producto",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

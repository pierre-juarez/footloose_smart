import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/convert_data_product.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/scan/loading_camera.dart';
import 'package:footloose_tickets/presentation/widgets/scan/modal_searching_product.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraContainer extends ConsumerWidget {
  const CameraContainer({
    super.key,
    required this.isInit,
    required this.mobileScannerController,
    required this.urlScan,
    required this.typeRequest,
  });

  final bool isInit;
  final MobileScannerController mobileScannerController;

  final String urlScan;
  final String typeRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> scanProduct(
      BuildContext context,
      BarcodeCapture capture,
    ) async {
      final listUpd = ref.watch(listProductProvider)['products'] ?? [];
      final product = ref.watch(productProvider);

      await mobileScannerController.stop();
      if (capture.barcodes.isNotEmpty) {
        final Barcode barcode = capture.barcodes[0];
        String codeProduct = barcode.rawValue ?? "";

        // Soporte para etiqueta unificada
        if (codeProduct.isNotEmpty && codeProduct.length == 23) {
          codeProduct = codeProduct.substring(0, 11);
        }

        if (!context.mounted) return;

        showError(
          context,
          icon: Icon(
            FontAwesomeIcons.check,
            size: 30,
            color: AppTheme.colorPrimary,
          ),
          title: "Código escaneado",
          errorMessage: "El código $codeProduct ha sido escaneado",
          onTap: () async {
            if (!context.mounted) return;
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const ModalSearchingProduct();
                });

            if (listUpd.isNotEmpty) {
              bool exists = listUpd.any((p) => p.sku == codeProduct);
              if (exists) {
                showError(
                  context,
                  title: "Error",
                  errorMessage: "El producto ya ha sido agregado a la fila",
                  onTap: () async {
                    await mobileScannerController.start();
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                );
                return;
              }
            }

            ProductDetailModel productDetail = await product.getProduct(codeProduct, urlScan, typeRequest);
            if (!context.mounted) return;

            if (productDetail.data == null) {
              showError(
                context,
                errorMessage: "Error al obtener detalle del producto, inténtalo nuevamente",
                title: "Error",
                onTap: () async {
                  await redirectToPage("/home");
                },
              );
              return;
            }
            context.pop();
            final etiqueta = await convertDataProduct(productDetail, context, ref);
            final etiquetaJson = jsonEncode(etiqueta.toJson());
            appRouter.go('/product?etiqueta=$etiquetaJson', extra: {'replace': true});
          },
        );
      }
      capture.barcodes.clear();
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: !isInit
          ? const LoadingCamera()
          : ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: MobileScanner(
                controller: mobileScannerController,
                onDetect: (capture) async {
                  await scanProduct(context, capture);
                },
              ),
            ),
    );
  }
}

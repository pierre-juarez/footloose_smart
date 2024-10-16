import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:footloose_tickets/config/helpers/convert_data_product.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/product_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/scan/button_outline.dart';
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
    void handleError(BuildContext context, String error) {
      VoidCallback? onTap;

      if (error.contains('El producto ya ha sido agregado a la fila')) {
        onTap = () async {
          await mobileScannerController.start();
          if (!context.mounted) return;
          context.pop();
        };
      } else if (error.contains('Error al obtener detalle del producto, inténtalo nuevamente')) {
        onTap = () async {
          await redirectToPage("/home");
        };
      }

      showError(
        context,
        errorMessage: error.replaceAll("Exception: ", ""),
        title: "Error",
        onTap: onTap,
      );
    }

    Future<void> scanProduct(
      BuildContext context,
      BarcodeCapture capture,
    ) async {
      try {
        final listUpd = ref.watch(listProductProvider)['products'] ?? [];
        final product = ref.watch(productProvider);

        await mobileScannerController.stop();
        if (capture.barcodes.isNotEmpty) {
          final Barcode barcode = capture.barcodes[0];
          String codeProduct = barcode.rawValue ?? "";
          codeProduct = codeProduct.replaceAll(RegExp(r'[^0-9]'), '');

          // Soporte para etiqueta unificada
          if (codeProduct.isNotEmpty && codeProduct.length == 23) {
            codeProduct = codeProduct.substring(0, 11);
          }

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
            bool exists = listUpd.any((p) => p.sku == codeProduct);
            if (exists) {
              throw Exception("El producto ya ha sido agregado a la fila");
            }
          }

          ProductDetailModel productDetail = await product.getProduct(codeProduct, urlScan, typeRequest);

          if (productDetail.data == null) {
            throw Exception("Error al obtener detalle del producto, inténtalo nuevamente");
          }
          if (!context.mounted) return;

          context.pop();

          final etiqueta = await convertDataProduct(productDetail, context, ref);
          final etiquetaJson = jsonEncode(etiqueta.toJson());
          appRouter.go('/product?etiqueta=$etiquetaJson', extra: {'replace': true});
        }
      } catch (e) {
        if (!context.mounted) return;
        handleError(context, e.toString());
      } finally {
        capture.barcodes.clear();
      }
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), boxShadow: AppStyles.shadowCard, color: AppColors.textLight),
      child: !isInit
          ? const LoadingCamera()
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Escanear Sticker del Código",
                        style: AppTextStyles.displayTextBasicCardLigth,
                      ),
                      SvgPicture.asset("lib/assets/flash.svg")
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: MobileScanner(
                    controller: mobileScannerController,
                    onDetect: (capture) async {
                      await scanProduct(context, capture);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: ButtonOutline(
                    title: "Ingreso Manual",
                    callback: () => context.push(
                      '/keyboard-screen',
                      extra: {
                        'mobileScannerController': mobileScannerController,
                        'urlScan': urlScan,
                        'typeRequest': typeRequest,
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

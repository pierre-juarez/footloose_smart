import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/product_model.dart';
import 'package:footloose_tickets/presentation/providers/camera/camera_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/navbar.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanerPage extends ConsumerWidget {
  static const name = "scaner-page";
  const ScanerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraProvider);
    final product = ref.watch(productProvider);
    print("🚀 ~ file: scan_product_screen.dart ~ line: 37 ~ TM_FUNCTION: ${camera.mobileScannerController.value.isRunning}");

    Future<void> scanProduct(
      BuildContext context,
      CameraProvider cameraController,
      BarcodeCapture capture,
    ) async {
      await cameraController.mobileScannerController.stop();
      if (capture.barcodes.isNotEmpty) {
        final Barcode barcode = capture.barcodes[0];
        //final Uint8List? image = capture.image;
        debugPrint('Barcode found! ${barcode.rawValue}');
        String codeProduct = barcode.rawValue ?? "";

        showError(
          context,
          icon: Icon(
            FontAwesomeIcons.check,
            size: 30,
            color: AppTheme.colorSecondary,
          ),
          title: "Código escaneado",
          errorMessage: "El código $codeProduct ha sido escaneado",
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 20));
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const _AlertSearchingProduct();
                });

            debugPrint("🚀 ~ file: scanner_page.dart ~ line: 102 ~ value search: $codeProduct");
            if (codeProduct.length >= 11 && codeProduct.length <= 12) {
              camera.mobileScannerController.stop();
              ProductModel productDetail = await product.getProduct(codeProduct);
              final productJson = jsonEncode(productDetail.toJson());
              await appRouter.pushReplacement('/product?productJson=$productJson');
            }
          },
        );
      }
      capture.barcodes.clear();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavbarHome(
                  onTap: () {
                    camera.mobileScannerController.stop();
                    redirectToPage("/home");
                  },
                ),
                const SizedBox(height: 10.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: MobileScanner(
                      controller: camera.mobileScannerController,
                      onDetect: (capture) async {
                        await scanProduct(
                          context,
                          camera,
                          capture,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextWidgetInput(
                  text: "¿Qué tengo que hacer?",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.backgroundColor,
                  textAlign: TextAlign.center,
                ),
                const RowInfoScann(
                  pathIcon: "lib/assets/scan.png",
                  textInfo: "Identifica el codigo de barras que se encuentra en la caja",
                ),
                const RowInfoScann(
                  pathIcon: "lib/assets/phone.png",
                  textInfo: "Acerca la camara al sticker del codigo, listo",
                ),
              ],
            ),
            // const _ButtonManual()
          ],
        ),
      ),
    );
  }
}

class _ButtonManual extends StatelessWidget {
  const _ButtonManual(); // required this.cameraController,

  // final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      right: 20.0,
      child: InkWell(
        onTap: () async {
          // await cameraController.mobileScannerController.stop();
          // navigateToPush(context, OnscreenKeyboard());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          decoration: BoxDecoration(
              color: AppTheme.colorSecondary,
              border: Border.all(color: AppTheme.colorSecondary),
              borderRadius: BorderRadius.circular(100.0)),
          child: const TextWidgetInput(
            text: "Ingreso manual",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _AlertSearchingProduct extends StatelessWidget {
  const _AlertSearchingProduct();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 150.0,
        width: 100.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidgetInput(
                  text: "Obteniendo información del producto...",
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  textAlign: TextAlign.center),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 50.0,
                width: 50.0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowInfoScann extends StatelessWidget {
  final String pathIcon;
  final String textInfo;

  const RowInfoScann({
    required this.pathIcon,
    required this.textInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(pathIcon),
          ),
          SizedBox(
            width: 250,
            child: TextWidgetInput(
              text: textInfo,
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

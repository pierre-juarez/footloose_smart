import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
// import 'package:footloose_puntodeventa/src/data/api/api.dart';
// import 'package:footloose_puntodeventa/src/data/api/consultForPartsSkuShoe_service.dart';
// import 'package:footloose_puntodeventa/src/data/api/consult_color_service.dart';
// import 'package:footloose_puntodeventa/src/data/provider/camera_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/credenciales_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/info_scanner_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/search_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/values_consult_detail_provider.dart';
// import 'package:footloose_puntodeventa/src/domian/models/colorModel/color_list_tiendas_model.dart';
// import 'package:footloose_puntodeventa/src/domian/models/colorModel/data_color_model.dart';
// import 'package:footloose_puntodeventa/src/domian/models/forPartsShoe_model.dart';
// import 'package:footloose_puntodeventa/src/helpers/helpers.dart';
// import 'package:footloose_puntodeventa/src/helpers/registerHistorial.dart';
// import 'package:footloose_puntodeventa/src/ui/common/style.dart';
// import 'package:footloose_puntodeventa/src/ui/common/textStyle.dart';
// import 'package:footloose_puntodeventa/src/ui/detail/pages/detail_page.dart';
// import 'package:footloose_puntodeventa/src/ui/keyboard/pages/onscreen_keyboard.dart';
// import 'package:footloose_puntodeventa/src/ui/scanner/widgets/rowInfoScann_widget.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/camera/camera_provider.dart';
import 'package:footloose_tickets/presentation/widgets/navbar.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanerPage extends ConsumerWidget {
  static const name = "scaner-page";
  const ScanerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraProvider);
    print("🚀 ~ file: scan_product_screen.dart ~ line: 37 ~ TM_FUNCTION: ${camera.mobileScannerController.value.isRunning}");

    Future<void> scanProduct(
      BuildContext context,
      CameraProvider cameraController,
      BarcodeCapture capture,
      // SearchProvider searchProvider,
      // CredencialesProvider credenciales,
      // ValuesConsultDetailShoe valuesConsultDetailShoe,
      // ConsultForPartsSkuShoeService consultSkuForParts,
      // InfoProductScannerProvider infoProductScannerProvider,
    ) async {
      // consultSkuForParts.loadingGelDetail = true;
      // consultSkuForParts.isQueryPrev = false;
      print("SCANNNER AQUI");
      await cameraController.mobileScannerController.stop();
      if (capture.barcodes.isNotEmpty) {
        final Barcode barcode = capture.barcodes[0];
        //final Uint8List? image = capture.image;
        debugPrint('Barcode found! ${barcode.rawValue}');
        String codeProduct = barcode.rawValue ?? "";

        showError(
          context,
          title: "Código escaneado",
          errorMessage: "El códido $codeProduct ha sido escaneado",
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
              // credenciales.codTienda = await SignInService.getCodTienda();
              // final String token = await LoginServiceWithToken.getToken();
              // final String store = credenciales.codTienda.substring(1);

              // valuesConsultDetailShoe.resetValues();

              // listCusOfShoe = await consultSkuForParts.consultForPartCUSofShoe(
              //   store,
              //   searchProvider.inputHoneyWell,
              //   "cus",
              //   token,
              // );

              // //* asignando datos de LISTA DE CU'S al provider de info detalle de producto escaneado
              // infoProductScannerProvider.listCusOfShoe = listCusOfShoe;

              // final DateTime now = DateTime.now();
              // final DateFormat formaterDate = DateFormat('yyyy-MM-dd');
              // final String fechaConsult = formaterDate.format(now);

              //llamada a la API para mostrar el detalle del producto
              // dataDetail = await consultSkuForParts.consultForPartsShoeDetail(
              //   store,
              //   searchProvider.inputHoneyWell,
              //   "detalle",
              //   fechaConsult,
              //   token,
              // );

              // final String modelID = dataDetail.idProdModelo.toString();

              // listOfColorModelId = await consultColorForModelIdService.consultColorForModelIdService(
              //   modelID,
              //   token,
              // );

              // await Future.delayed(const Duration(milliseconds: 200)).whenComplete(() {
              //   List<ColorModel> listOnlyTallaOfSearch = [];
              //   List<String> listOnlyColor = [];
              //   for (ColorModel element in listOfColorModelId) {
              //     if (!(element.talla.contains("."))) {
              //       element.talla = element.talla + ".0";
              //     }
              //     if (element.talla == dataDetail.talla) {
              //       listOnlyTallaOfSearch.add(element);
              //       listOnlyColor.add(element.hex);
              //     }
              //   }
              //   listOnlyColor = listOnlyColor.toSet().toList();
              //   listColorTiendasOfModel = [];
              //   for (String onlyColor in listOnlyColor) {
              //     List<TiendasAndStockForColor> tiendaAndStockTemp = [];
              //     for (ColorModel element in listOnlyTallaOfSearch) {
              //       if (element.hex == onlyColor) {
              //         final stock = element.cantidad.toString();
              //         TiendasAndStockForColor tiendasAndStockForColor = TiendasAndStockForColor(
              //           stock: stock,
              //           tienda: element.tienda,
              //           sku: element.sku,
              //           colorLabel: element.color,
              //         );
              //         tiendaAndStockTemp.add(tiendasAndStockForColor);
              //       }
              //     }
              //     onlyColor = onlyColor.substring(1);
              //     onlyColor = "ff$onlyColor";
              //     ColorListTiendasOfModel tempColorListTiendaModel = ColorListTiendasOfModel(
              //       color: onlyColor,
              //       colorLabel: tiendaAndStockTemp[0].colorLabel,
              //       talla: dataDetail.talla ?? "",
              //       tiendasAndStock: tiendaAndStockTemp,
              //       sku: tiendaAndStockTemp[0].sku,
              //     );
              //     listColorTiendasOfModel.add(tempColorListTiendaModel);
              //   }

              //   searchProvider.inputHoneyWell = "";
              // });
              //* asignando datos de DATA DETAIL al provider de info detalle de producto escaneado
              // infoProductScannerProvider.dataDetail = dataDetail;
              // infoProductScannerProvider.listOfColorsByModelId = listColorTiendasOfModel;
              // Navigator.pop(context);
              // await Future.delayed(const Duration(milliseconds: 200));

              // navigateToPush(
              //   context,
              //   DetailProductPage(
              //     codMarca: infoProductScannerProvider.dataDetail.imagenMarca.toString(),
              //     description: infoProductScannerProvider.dataDetail.descripcion.toString(),
              //     offerPrice: infoProductScannerProvider.dataDetail.precioOferta ?? 0.0,
              //     pathImage: infoProductScannerProvider.dataDetail.enlaceProducto ?? "",
              //     price: infoProductScannerProvider.dataDetail.precio ?? 0.0,
              //     sku: infoProductScannerProvider.dataDetail.sku ?? "0",
              //     stock: dataDetail.stockTienda ?? 0,
              //     textEditingController: _textEditingController,
              //     dataDetail: infoProductScannerProvider.dataDetail,
              //     listCusOfShoe: listCusOfShoe,
              //     categoria: infoProductScannerProvider.dataDetail.categoria ?? "Categoria",
              //     subCategoria: infoProductScannerProvider.dataDetail.subCategoria ?? "Subcategoria",
              //     talla: infoProductScannerProvider.dataDetail.talla ?? "Talla",
              //   ),
              // );

              // consultSkuForParts.loadingGelDetail = false;
              await Future.delayed(const Duration(seconds: 5));
              camera.mobileScannerController.stop();
              await redirectToPage("/product");
            }
          },
        );

        // searchProvider.inputHoneyWell = barcode.rawValue ?? "";
        // infoProductScannerProvider.listOfColorsByModelId = [];
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
                // ImageLogoFootloose(),
                const SizedBox(height: 10.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: MobileScanner(
                      // fit: BoxFit.contain,
                      controller: camera.mobileScannerController,
                      onDetect: (capture) async {
                        await scanProduct(
                          context,
                          camera,
                          capture,
                          // searchProvider,
                          // credenciales,
                          // valuesConsultDetailShoe,
                          // consultSkuForParts,
                          // infoProductScannerProvider,
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
                  text: "Buscando producto",
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

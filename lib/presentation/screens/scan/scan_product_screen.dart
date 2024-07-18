import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/navbar.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanerPage extends ConsumerStatefulWidget {
  static const name = "scaner-page";
  const ScanerPage({
    super.key,
    required this.urlScan,
    required this.typeRequest,
  });
  final String urlScan;
  final String typeRequest;

  @override
  ScannerPageState createState() => ScannerPageState();
}

class ScannerPageState extends ConsumerState<ScanerPage> {
  late final MobileScannerController mobileScannerController;
  bool isInit = false;

  @override
  void initState() {
    super.initState();
    mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoStart: false,
      formats: [BarcodeFormat.code128, BarcodeFormat.code39, BarcodeFormat.all],
    );
    mobileScannerController.stop();
    _startCamera();
  }

  @override
  void dispose() {
    super.dispose();
    mobileScannerController.stop();
    mobileScannerController.dispose();
  }

  Future<void> _startCamera() async {
    try {
      setState(() {
        isInit = false;
      });
      await Future.delayed(const Duration(milliseconds: 800));
      await mobileScannerController.start();
      setState(() {
        isInit = true;
      });
    } catch (e) {
      print("🚀 ~ Error al aperturar la cámara: $e");
      showError(
        context,
        title: "Error",
        errorMessage: "No se ha podido aperturar la cámara, cierra y abre la aplicación",
        onTap: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productProvider);
    final list = ref.watch(listProductProvider)['products'] ?? [];

    List<EtiquetaModel> skusUnicos = list.toSet().toList();

    print("🚀 ~ file: scan_product_screen.dart ~ line: 38 ~ TM_FUNCTION: ${mobileScannerController.value.isRunning}");

    Future<void> viewPrint() async {
      final listsJson = jsonEncode(list.map((product) => product.toJson()).toList());
      await appRouter.pushReplacement('/review-queue?etiquetas=$listsJson');
    }

    Future<void> scanProduct(
      BuildContext context,
      BarcodeCapture capture,
    ) async {
      final listUpd = ref.watch(listProductProvider)['products'] ?? [];

      await mobileScannerController.stop();
      if (capture.barcodes.isNotEmpty) {
        final Barcode barcode = capture.barcodes[0];
        String codeProduct = barcode.rawValue ?? "";

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
            await Future.delayed(const Duration(milliseconds: 20));
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const _AlertSearchingProduct();
                });

            debugPrint("🚀 ~ file: scanner_page.dart ~ line: 102 ~ value search: $codeProduct");

            if (codeProduct.length >= 11 && codeProduct.length <= 12) {
              if (listUpd.isNotEmpty) {
                bool exists = listUpd.any((p) => p.sku == codeProduct);
                if (exists) {
                  showError(
                    context,
                    title: "Error",
                    errorMessage: "El producto ya ha sido agregado a la fila",
                    onTap: () async {
                      await mobileScannerController.start();
                      Navigator.of(context).pop();
                    },
                  );
                  return;
                }
              }

              ProductDetailModel productDetail = await product.getProduct(codeProduct, widget.urlScan, widget.typeRequest);

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
              final productJson = jsonEncode(productDetail.toJson());
              await appRouter.pushReplacement('/product?productJson=$productJson');
            }
          },
        );
      }
      capture.barcodes.clear();
    }

    Future<void> deleteAllItems() async {
      deleteAllItemsQueue(ref, context, () {
        setState(() {});
      });
    }

    Widget? floatingOption = (list.isNotEmpty)
        ? FloatingActionButton(
            onPressed: () async => viewPrint(),
            child: const Icon(Icons.print_outlined),
          )
        : null;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: floatingOption,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavbarHome(
                  onTap: () => redirectToPage("/home"),
                ),
                const SizedBox(height: 10.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: !isInit
                      ? const _LoadingCamera()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: MobileScanner(
                            controller: mobileScannerController,
                            onDetect: (capture) async {
                              await scanProduct(context, capture);
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
                  textInfo: "Identifica el código de barras que se encuentra en la caja",
                ),
                const RowInfoScann(
                  pathIcon: "lib/assets/phone.png",
                  textInfo: "Acerca la cámara al sticker del código, listo",
                ),
                Visibility(
                  visible: list.isNotEmpty,
                  child: Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Text(
                                "Productos en cola: ${skusUnicos.length}",
                                style:
                                    robotoStyle(18, FontWeight.bold, Colors.black).copyWith(decoration: TextDecoration.underline),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("(Desliza a la izquierda para eliminar)"),
                                  InkWell(
                                    onTap: () async => deleteAllItems(),
                                    child: Text(
                                      "Vaciar todo",
                                      style: robotoStyle(15, FontWeight.bold, Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  itemCount: skusUnicos.length,
                                  itemBuilder: (context, index) {
                                    final product = skusUnicos[index];
                                    return Dismissible(
                                      key: Key(product.sku),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss: (DismissDirection direction) async {
                                        bool deleteConfirmed = await showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Confirmación',
                                                style: robotoStyle(20, FontWeight.w600, Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Text(
                                                '¿Estás seguro de que quieres eliminar un producto del SKU: ${product.sku}?',
                                                style: robotoStyle(15, FontWeight.normal, Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: <Widget>[
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () => Navigator.of(context).pop(true),
                                                        child: const ButtonPrimary(
                                                          validator: false,
                                                          title: "Eliminar",
                                                          type: "small",
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () => Navigator.of(context).pop(false),
                                                        child: ButtonPrimary(
                                                          validator: false,
                                                          title: "Cancelar",
                                                          type: "small",
                                                          color: AppTheme.colorSecondary,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );

                                        return deleteConfirmed;
                                      },
                                      onDismissed: (direction) async {
                                        if (direction == DismissDirection.endToStart) {
                                          ref.read(listProductProvider.notifier).deleteProduct(product.sku);

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Producto del SKU: ${product.sku} eliminado'),
                                              duration: const Duration(milliseconds: 1000),
                                            ),
                                          );
                                        }
                                      },
                                      background: Container(
                                          color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(Icons.delete, color: Colors.white),
                                              SizedBox(width: 8),
                                              Text(
                                                'Eliminar',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black, width: 1),
                                                borderRadius: BorderRadius.circular(15)),
                                            child: ListTile(
                                              title: Text("${index + 1}.- SKU ${product.sku} - ${product.modelo}"),
                                            ),
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                )
              ],
            ),
            // const _ButtonManual()
          ],
        ),
      ),
    );
  }
}

class _LoadingCamera extends StatelessWidget {
  const _LoadingCamera();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
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
              color: AppTheme.colorPrimary,
              border: Border.all(color: AppTheme.colorPrimary),
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

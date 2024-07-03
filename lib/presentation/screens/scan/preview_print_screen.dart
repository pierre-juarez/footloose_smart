import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_basic.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

class PreviewPrintScreen extends ConsumerStatefulWidget {
  static const name = "preview-print-screen";
  const PreviewPrintScreen({
    super.key,
    required this.etiqueta,
  });

  final EtiquetaModel etiqueta;

  @override
  PreviewPrintScreenState createState() => PreviewPrintScreenState();
}

class PreviewPrintScreenState extends ConsumerState<PreviewPrintScreen> {
  final GlobalKey _globalKey = GlobalKey();
  bool loadingPrint = false;
  bool addingQueue = false;
  bool cancelProcess = false;

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(0);
      return byteData.buffer.asUint8List();
    } catch (e) {
      print("Error al capturar la imagen: $e");
      showError(context, title: "Error", errorMessage: "Error al capturar una imagen. Cierra y abre el app.");
    }
    return Uint8List(0);
  }

  void _navigateToPrintScreen() async {
    setState(() {
      loadingPrint = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    bool isVerify = await verifyBluetooth();

    if (isVerify) {
      Uint8List pngBytes = await _capturePng();
      if (pngBytes.isNotEmpty) {
        final imageBytesBase64 = Uri.encodeComponent(base64Encode(pngBytes));
        context.push('/print?image=$imageBytesBase64');
      } else {
        print("Error capturando la imagen y navegando a pantalla de impresión");
      }
    } else {
      showBluetoothDialog(context, () {
        Navigator.pop(context);
      });
    }
    setState(() {
      loadingPrint = false;
    });
  }

  Future<void> _cancelProcess() async {
    deleteAllItemsQueue(ref, context, () async {
      setState(() {
        cancelProcess = true;
      });
      await redirectToPage("/home");
    });
  }

  Future<void> _redirectToScan() async {
    await redirectToPage("/scan");
  }

  Future<void> _addQueue(EtiquetaModel product) async {
    try {
      setState(() {
        addingQueue = true;
      });
      final list = ref.watch(listProductProvider)['products'] ?? [];
      bool exists = list.any((p) => p.sku == product.sku);

      if (!exists) {
        ref.read(listProductProvider.notifier).saveProduct(product);
        showErrorTwo(
          context,
          title: "Ítem agregado",
          errorMessage: "El producto ha sido agregado a la fila",
          onTap: () async {
            await _redirectToScan();
          },
          buttonText: "Agregar +",
          buttonText2: "Visualizar",
          icon: Icon(
            FontAwesomeIcons.checkToSlot,
            color: AppTheme.colorSecondary,
            size: 30,
          ),
        );
      } else {
        showError(context, title: "Error", errorMessage: "El producto ya ha sido agregado a la fila");
      }
      setState(() {
        addingQueue = false;
      });
    } catch (e) {
      print("🚀 ~ Error al agregar a la fila: $e");
      showError(context, title: "Error", errorMessage: "Error al agregar a la fila. Cierra y abre el app.");
    }
  }

  Future<void> _handleReviewQueue() async {
    final list = ref.watch(listProductProvider)['products']!;
    final listsJson = jsonEncode(list.map((product) => product.toJson()).toList());
    await context.push('/review-queue?etiquetas=$listsJson');
  }

  @override
  Widget build(BuildContext context) {
    final barcode = Barcode.code128();
    final svg = barcode.toSvg(widget.etiqueta.sku, width: 400, height: 150);
    final list = ref.watch(listProductProvider);

    return SafeArea(
        child: Scaffold(
      appBar: const AppBarCustom(title: "Previsualización de etiqueta"),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  RepaintBoundary(
                    key: _globalKey,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 40),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(border: Border.all(color: AppTheme.colorPrimary, width: 2)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextDescription(description: widget.etiqueta.marcaAbrev),
                                  TextDescription(description: widget.etiqueta.tipoArticulo),
                                  TextDescription(description: widget.etiqueta.modelo),
                                  TextDescription(description: widget.etiqueta.color),
                                  TextDescription(description: widget.etiqueta.material),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.etiqueta.precio,
                                    style: robotoStyle(19, FontWeight.w500, Colors.black),
                                  ),
                                  TextDescription(description: widget.etiqueta.talla),
                                  Row(
                                    children: [
                                      Text("SKU:", style: robotoStyle(15, FontWeight.w900, Colors.black)),
                                      Text(
                                        widget.etiqueta.sku,
                                        style: robotoStyle(18, FontWeight.w500, Colors.black),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SvgPicture.string(
                            svg,
                            fit: BoxFit.contain,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextDescription(description: widget.etiqueta.fechaCreacion),
                              TextDescription(description: widget.etiqueta.temporada),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _navigateToPrintScreen,
                    child: ButtonPrimary(validator: loadingPrint, title: "Imprimir solo este ítem"),
                  ),
                  Visibility(
                    visible: list['products']?.isNotEmpty ?? false,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () async => _redirectToScan(),
                          child: const ButtonBasic(state: true, title: "Agregar otro producto"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async => _addQueue(widget.etiqueta),
                    child: ButtonPrimary(validator: addingQueue, title: "Agregar a la fila"),
                  ),
                  Visibility(
                    visible: list['products']?.isNotEmpty ?? false,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () async => _handleReviewQueue(),
                          child: const ButtonBasic(state: true, title: "Revisar fila"),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: list['products']?.isNotEmpty ?? false,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () async => _cancelProcess(),
                            child: ButtonPrimary(validator: cancelProcess, title: "Cancelar proceso"),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Ítems en la fila: ", style: robotoStyle(16, FontWeight.bold, Colors.black)),
                            TextSpan(
                                text: "${list['products']?.length ?? 0}", style: robotoStyle(16, FontWeight.normal, Colors.black))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class TextDescription extends StatelessWidget {
  const TextDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(description, style: robotoStyle(15, FontWeight.w500, Colors.black));
  }
}

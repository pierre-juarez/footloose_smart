import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
import 'package:footloose_tickets/presentation/providers/product/queue_active_provider.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_basic.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

class PreviewPrintScreen extends ConsumerStatefulWidget {
  static const name = "preview-print-screen";

  const PreviewPrintScreen({
    super.key,
    required this.etiquetas,
    required this.state,
  });

  final List<EtiquetaModel> etiquetas;
  final bool state;

  @override
  PreviewPrintScreenState createState() => PreviewPrintScreenState();
}

class PreviewPrintScreenState extends ConsumerState<PreviewPrintScreen> {
  final GlobalKey _globalKey = GlobalKey();
  List<GlobalKey> _globalKeys = [];
  bool loadingPrint = false;
  bool addingQueue = false;
  bool cancelProcess = false;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _globalKeys = List.generate(widget.etiquetas.length, (index) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.state) {
        _addQueue(widget.etiquetas[0]);
      }
    });
  }

  Future<Uint8List> _capturePng() async {
    try {
      List<Uint8List> pngBytesList = [];

      for (GlobalKey key in _globalKeys) {
        RenderRepaintBoundary? boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
        if (boundary != null) {
          ui.Image image = await boundary.toImage();
          ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(0);
          pngBytesList.add(byteData.buffer.asUint8List());
        } else {
          print("No se encontró RenderRepaintBoundary para una de las etiquetas.");
        }
      }

      if (pngBytesList.isEmpty) {
        print("No se capturaron imágenes válidas.");
        return Uint8List(0);
      }

      // Combinar las imágenes en una sola con espacio entre ellas
      ui.PictureRecorder recorder = ui.PictureRecorder();
      Canvas canvas = Canvas(recorder);
      double yOffset = 0.0;
      const double separation = 20.0; // Espacio entre imágenes

      for (Uint8List pngBytes in pngBytesList) {
        ui.Image image = await decodeImageFromList(pngBytes);
        canvas.drawImage(image, Offset(0, yOffset), Paint());
        yOffset += image.height.toDouble() + separation;
      }

      ui.Image finalImage = await recorder.endRecording().toImage(
            400, // Ajustar el ancho total
            yOffset.toInt(),
          );
      ByteData byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(0);

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
      // final queueState = ref.watch(queueActiveProvider);
      bool exists = list.any((p) => p.sku == product.sku);
      int countItems = widget.etiquetas.length;

      if (!exists) {
        ref.read(queueActiveProvider.notifier).changeState();
        for (var i = 0; i < countItems; i++) {
          ref.read(listProductProvider.notifier).saveProduct(product);
        }
        !widget.state ? modalErrorOne() : modalErrorTwo();
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

  Future<void> modalErrorOne() {
    return showError(
      context,
      title: "Ítem agregado",
      errorMessage: "El producto ha sido agregado a la fila",
      onTap: () async {
        await _redirectToScan();
      },
      buttonText: "Agregar +",
      icon: Icon(
        FontAwesomeIcons.checkToSlot,
        color: AppTheme.colorSecondary,
        size: 30,
      ),
    );
  }

  Future<void> modalErrorTwo() {
    return showErrorTwo(
      context,
      title: "Ítem agregado",
      errorMessage: "El producto ha sido agregado a la fila",
      onTap: () async {
        await _redirectToScan();
      },
      buttonText: "Agregar +",
      buttonText2: "Continuar",
      icon: Icon(
        FontAwesomeIcons.checkToSlot,
        color: AppTheme.colorSecondary,
        size: 30,
      ),
    );
  }

  Future<void> _handleReviewQueue() async {
    final list = ref.watch(listProductProvider)['products'] ?? [];
    final listsJson = jsonEncode(list.map((product) => product.toJson()).toList());
    await context.push('/review-queue?etiquetas=$listsJson');
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(listProductProvider)['products'] ?? [];
    final barcode = Barcode.code128();
    List<String> svgs = [];
    for (var etiqueta in widget.etiquetas) {
      final svg = barcode.toSvg(etiqueta.sku, width: 400, height: 150);
      svgs.add(svg);
    }
    // final svg = barcode.toSvg(widget.etiqueta.sku, width: 400, height: 150);
    List<EtiquetaModel> listProducts = list;
    int countItems = listProducts.length;

    Set<String> skusUnicos = listProducts.map((etiqueta) => etiqueta.sku).toSet();
    int countProducts = skusUnicos.length;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await redirectToPage("/scan"),
          child: const Icon(FontAwesomeIcons.camera),
        ),
        appBar: const AppBarCustom(title: "Previsualización de etiqueta"),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text(
                  "1.- SKU: ${widget.etiquetas[0].sku} - ${widget.etiquetas[0].modelo} - ${widget.etiquetas.length} etiqueta${widget.etiquetas.isNotEmpty ? "s" : ""}"),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.etiquetas.length,
                  itemBuilder: (context, index) {
                    final etiqueta = widget.etiquetas[index];
                    final svg = svgs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RepaintBoundary(
                          key: _globalKeys[index],
                          child: _TicketDetail(etiqueta: etiqueta, svg: svg),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _navigateToPrintScreen,
                    child: ButtonPrimary(validator: loadingPrint, title: "Imprimir ${countProducts > 0 ? "solo este" : ""} ítem"),
                  ),
                  Visibility(
                    visible: !widget.state,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () async => _addQueue(widget.etiquetas[0]),
                          child: ButtonPrimary(validator: addingQueue, title: "Agregar a la fila"),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: list.isNotEmpty,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () async => _handleReviewQueue(),
                          child: const ButtonPrimary(validator: false, title: "Imprimir todos los ítems"),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: list.isNotEmpty,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () async => _cancelProcess(),
                            child: ButtonPrimary(
                              validator: cancelProcess,
                              title: "Cancelar proceso",
                              color: AppTheme.colorSecondary,
                            ),
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
                            TextSpan(text: "$countItems", style: robotoStyle(16, FontWeight.normal, Colors.black))
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Productos en la fila: ", style: robotoStyle(16, FontWeight.bold, Colors.black)),
                            TextSpan(text: "$countProducts", style: robotoStyle(16, FontWeight.normal, Colors.black))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TicketDetail extends StatelessWidget {
  const _TicketDetail({
    required this.etiqueta,
    required this.svg,
  });

  final EtiquetaModel etiqueta;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.colorPrimary, width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextDescription(description: etiqueta.marcaAbrev),
                  TextDescription(description: etiqueta.tipoArticulo),
                  TextDescription(description: etiqueta.modelo),
                  TextDescription(description: etiqueta.color),
                  TextDescription(description: etiqueta.material),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    etiqueta.precio,
                    style: robotoStyle(19, FontWeight.w500, Colors.black),
                  ),
                  TextDescription(description: etiqueta.talla),
                  Row(
                    children: [
                      Text("SKU:", style: robotoStyle(15, FontWeight.w900, Colors.black)),
                      Text(
                        etiqueta.sku,
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
              TextDescription(description: etiqueta.fechaCreacion),
              TextDescription(description: etiqueta.temporada),
            ],
          )
        ],
      ),
    );
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

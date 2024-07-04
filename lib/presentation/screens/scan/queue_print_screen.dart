import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_basic.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

class QueuePrintScreen extends ConsumerStatefulWidget {
  static const name = "queue-print-screen";
  const QueuePrintScreen({
    super.key,
    required this.etiquetas,
  });

  final List<EtiquetaModel> etiquetas;

  @override
  QueuePrintScreenState createState() => QueuePrintScreenState();
}

class QueuePrintScreenState extends ConsumerState<QueuePrintScreen> {
  List<GlobalKey> _globalKeys = [];
  bool loadingPrint = false;

  @override
  void initState() {
    super.initState();
    _globalKeys = List.generate(widget.etiquetas.length, (index) => GlobalKey());
  }

  Future<Uint8List> _capturePng() async {
    try {
      List<Uint8List> pngBytesList = [];

      for (GlobalKey key in _globalKeys) {
        RenderRepaintBoundary? boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
        if (boundary != null) {
          if (boundary.debugNeedsPaint) {
            // Esperar un frame más si necesita ser pintado
            await Future.delayed(const Duration(milliseconds: 20));
            await WidgetsBinding.instance.endOfFrame;
            boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
            if (boundary == null || boundary.debugNeedsPaint) {
              print("El widget aún necesita pintarse después del retraso y el fin del frame.");
              continue; // O saltar este widget
            }
          }
          ui.Image image = await boundary.toImage(pixelRatio: 3.0);
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
    // TODO  - DESPUÉS DE IMPRIMIR RESETEAR EL VALOR DE QUEUEACTIVE
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

  Future<void> _cancel() async {
    deleteAllItemsQueue(ref, context, () async {
      await redirectToPage("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    final barcode = Barcode.code128();
    // final svg = barcode.toSvg(widget.etiqueta.sku, width: 400, height: 150);
    List<String> svgs = [];
    for (var etiqueta in widget.etiquetas) {
      final svg = barcode.toSvg(etiqueta.sku, width: 400, height: 150);
      svgs.add(svg);
    }
    print("🚀 ~ file: queue_print_screen.dart ~ line: 89 ~ TM_FUNCTION: ${widget.etiquetas.length}");

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarCustom(title: "Lista de Etiquetas"),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              _Title(widget: widget),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.etiquetas.length,
                  itemBuilder: (context, index) {
                    final etiqueta = widget.etiquetas[index];
                    final svg = svgs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${index + 1}.- SKU: ${etiqueta.sku} - ${etiqueta.modelo}"),
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
                    child: ButtonPrimary(validator: loadingPrint, title: "Imprimir ${widget.etiquetas.length} ítems"),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async => await redirectToPage("/scan"),
                    child: const ButtonBasic(state: true, title: "Editar ítems"),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async => _cancel(),
                    child: ButtonPrimary(
                      validator: false,
                      title: "Cancelar operación",
                      color: AppTheme.colorSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
    required this.widget,
  });

  final QueuePrintScreen widget;

  @override
  Widget build(BuildContext context) {
    List<EtiquetaModel> listProducts = widget.etiquetas;
    int countItems = listProducts.length;

    Set<String> skusUnicos = listProducts.map((etiqueta) => etiqueta.sku).toSet();
    int countProducts = skusUnicos.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Ítems en la fila: ", style: robotoStyle(18, FontWeight.bold, Colors.black)),
              TextSpan(text: "$countItems", style: robotoStyle(18, FontWeight.normal, Colors.black))
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Productos en la fila: ", style: robotoStyle(18, FontWeight.bold, Colors.black)),
              TextSpan(text: "$countProducts", style: robotoStyle(18, FontWeight.normal, Colors.black))
            ],
          ),
        )
      ],
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

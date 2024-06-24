import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

class PreviewPrintScreen extends StatefulWidget {
  static const name = "preview-print-screen";
  const PreviewPrintScreen({
    super.key,
    required this.etiqueta,
  });

  final EtiquetaModel etiqueta;

  @override
  State<PreviewPrintScreen> createState() => _PreviewPrintScreenState();
}

class _PreviewPrintScreenState extends State<PreviewPrintScreen> {
  final GlobalKey _globalKey = GlobalKey();
  bool loadingPrint = false;

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(0);
      return byteData.buffer.asUint8List();
    } catch (e) {
      print("Error al capturar la imagen: $e");
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

  @override
  Widget build(BuildContext context) {
    final barcode = Barcode.code128();
    final svg = barcode.toSvg(widget.etiqueta.sku, width: 400, height: 150);

    return SafeArea(
        child: Scaffold(
      appBar: const AppBarCustom(title: "Previsualización de etiqueta"),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(border: Border.all(color: AppTheme.colorSecondary, width: 2)),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: InkWell(
                    onTap: _navigateToPrintScreen,
                    child: ButtonPrimary(validator: loadingPrint, title: "Imprimir"),
                  ),
                )
              ],
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

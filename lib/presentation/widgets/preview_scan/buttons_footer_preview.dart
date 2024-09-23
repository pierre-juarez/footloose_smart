import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'dart:ui' as ui;
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

class ButtonsFooterPreview extends ConsumerStatefulWidget {
  const ButtonsFooterPreview({
    super.key,
    required List<GlobalKey<State<StatefulWidget>>> globalKeys,
  }) : _globalKeys = globalKeys;

  final List<GlobalKey<State<StatefulWidget>>> _globalKeys;

  @override
  ButtonsFooterPreviewState createState() => ButtonsFooterPreviewState();
}

class ButtonsFooterPreviewState extends ConsumerState<ButtonsFooterPreview> {
  bool validCancelProcess = false;
  bool loadingPrint = false;

  @override
  Widget build(BuildContext context) {
    final List<EtiquetaModel> listProducts = ref.watch(listProductProvider)['products'] ?? [];

    Future<List<Uint8List>> capturePng() async {
      try {
        List<Uint8List> pngBytesList = [];

        for (GlobalKey key in widget._globalKeys) {
          RenderRepaintBoundary? boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

          if (boundary != null) {
            if (boundary.debugNeedsPaint) {
              await Future.delayed(const Duration(milliseconds: 20));
              await WidgetsBinding.instance.endOfFrame;
              boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
              if (boundary == null || boundary.debugNeedsPaint) {
                infoLog("El widget aún necesita pintarse después del retraso y el fin del frame.");
                continue; // O saltar este widget
              }
            }

            // Capturar la imagen del widget
            ui.Image image = await boundary.toImage(pixelRatio: 1.0);
            ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(0);
            pngBytesList.add(byteData.buffer.asUint8List());
          } else {
            throw Exception("No se encontró RenderRepaintBoundary para una de las etiquetas.");
          }
        }

        if (pngBytesList.isEmpty) {
          throw Exception("No se capturaron imágenes válidas.");
        }

        return pngBytesList;
      } catch (e) {
        errorLog("Error al capturar las imágenes: $e");
        if (!context.mounted) return [];
        showError(context, title: "Error", errorMessage: "Error al capturar las imágenes. Cierra y abre la app.");
      }
      return [];
    }

    Future<void> captureAndNavigate(BuildContext context) async {
      try {
        List<Uint8List> pngBytesList = await capturePng();

        if (!context.mounted) return;

        if (pngBytesList.isNotEmpty) {
          List<Map<String, dynamic>> imagePrintsList = [];

          for (int i = 0; i < pngBytesList.length; i++) {
            if (i < listProducts.length) {
              final etiqueta = listProducts[i];
              final imageBytesBase64 = Uri.encodeComponent(base64Encode(pngBytesList[i]));
              final numberOfPrints = etiqueta.numberOfPrints;

              imagePrintsList.add({
                'image': imageBytesBase64,
                'numberprints': numberOfPrints,
              });
            }
          }

          final jsonEncodedList = Uri.encodeComponent(jsonEncode(imagePrintsList));

          context.push('/print?images=$jsonEncodedList');
        } else {
          throw Exception("Error capturando las imágenes y navegando a la pantalla de impresión");
        }
      } catch (e) {
        showError(context, title: "Error", errorMessage: e.toString());
      }
    }

    void navigateToPrintScreen() async {
      setState(() => loadingPrint = true);

      await Future.delayed(const Duration(milliseconds: 100));

      bool isVerify = await verifyBluetooth();

      if (!context.mounted) return;

      if (isVerify) {
        captureAndNavigate(context);
      } else {
        showBluetoothDialog(context, () {
          Navigator.pop(context);
        });
      }
      setState(() => loadingPrint = false);
    }

    Future<void> cancelProcess() async {
      deleteAllItemsQueue(ref, context, () async {
        setState(() => validCancelProcess = true);
        await redirectToPage("/home");
      });
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          InkWell(
            onTap: navigateToPrintScreen,
            child: ButtonPrimary(validator: loadingPrint, title: "Imprimir", icon: Icons.print_outlined),
          ),
          Visibility(
            visible: listProducts.isNotEmpty,
            child: Column(
              children: [
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async => await cancelProcess(),
                  child: ButtonPrimary(
                    icon: Icons.cancel,
                    validator: validCancelProcess,
                    title: "Cancelar operación",
                    color: AppTheme.colorSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () async => await redirectToScan(context),
                      child: const Icon(FontAwesomeIcons.barcode),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

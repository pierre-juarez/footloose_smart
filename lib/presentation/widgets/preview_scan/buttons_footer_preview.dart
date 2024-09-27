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
import 'package:footloose_tickets/presentation/widgets/scan/modal_searching_product.dart';
import 'package:go_router/go_router.dart';

class ButtonsFooterPreview extends ConsumerStatefulWidget {
  const ButtonsFooterPreview({
    super.key,
    required List<GlobalKey<State<StatefulWidget>>> globalKeys,
    required this.scrollController,
  }) : _globalKeys = globalKeys;

  final List<GlobalKey<State<StatefulWidget>>> _globalKeys;
  final ScrollController scrollController;

  @override
  ButtonsFooterPreviewState createState() => ButtonsFooterPreviewState();
}

class ButtonsFooterPreviewState extends ConsumerState<ButtonsFooterPreview> {
  bool validCancelProcess = false;
  bool loadingPrint = false;

  @override
  Widget build(BuildContext context) {
    final List<EtiquetaModel> listProducts = ref.watch(listProductProvider)['products'] ?? [];

    void showLoadingPrint() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const PopScope(
          canPop: false,
          child: ModalProcessProduct(message: "Capturando etiquetas..."),
        ),
      );
    }

    Future<List<Uint8List>> capturePng() async {
      List<Uint8List> pngBytesList = [];

      for (int i = 0; i < widget._globalKeys.length; i++) {
        GlobalKey key = widget._globalKeys[i];

        // Desplazarse al widget actual para asegurarse de que esté renderizado
        await widget.scrollController.animateTo(
          widget.scrollController.position.minScrollExtent + i * 350.0, // Ajusta este valor según el tamaño de cada widget
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );

        await Future.delayed(const Duration(milliseconds: 300)); // Espera un tiempo para asegurarse de que se renderice

        RenderRepaintBoundary? boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

        if (boundary != null) {
          if (boundary.debugNeedsPaint) {
            await Future.delayed(const Duration(milliseconds: 20));
            await WidgetsBinding.instance.endOfFrame;
            boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
            if (boundary == null || boundary.debugNeedsPaint) {
              infoLog("El widget aún necesita pintarse después del retraso y el fin del frame. - $key");
              continue;
            }
          }

          // Capturar la imagen del widget
          ui.Image image = await boundary.toImage(pixelRatio: 1.0);
          ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(0);
          pngBytesList.add(byteData.buffer.asUint8List());
        } else {
          infoLog("No se encontró RenderRepaintBoundary para la etiqueta $key");
          throw Exception("No se encontró RenderRepaintBoundary para una de las etiquetas.");
        }
      }

      if (pngBytesList.isEmpty) {
        throw Exception("No se capturaron imágenes válidas.");
      }

      return pngBytesList;
    }

    Future<void> captureAndNavigate(BuildContext context) async {
      try {
        showLoadingPrint();

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
          Navigator.pop(context);
          context.push('/print?images=$jsonEncodedList');
        } else {
          throw Exception("Error capturando las imágenes y navegando a la pantalla de impresión");
        }
      } catch (e) {
        String error = e.toString().replaceAll("Exception: ", "");
        errorLog(e.toString());
        showError(context, title: "Error", errorMessage: "Error al capturar las imágenes. $error");
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

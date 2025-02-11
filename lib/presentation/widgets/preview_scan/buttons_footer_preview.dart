import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'dart:ui' as ui;
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/custom_modal.dart';
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

        await widget.scrollController.animateTo(
          widget.scrollController.position.minScrollExtent + i * 350.0, // Ajusta este valor
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );

        await Future.delayed(const Duration(milliseconds: 500)); // Aumenta el tiempo de espera

        RenderRepaintBoundary? boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

        if (boundary != null) {
          if (boundary.debugNeedsPaint) {
            await Future.delayed(const Duration(milliseconds: 50));
            await WidgetsBinding.instance.endOfFrame;
            boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
            if (boundary == null || boundary.debugNeedsPaint) {
              infoLog("El widget aún necesita pintarse después del retraso y el fin del frame. - $key");
              continue;
            }
          }

          try {
            ui.Image image = await boundary.toImage(pixelRatio: 1.0);
            ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(0);
            pngBytesList.add(byteData.buffer.asUint8List());
          } catch (e) {
            infoLog("Error al capturar la imagen del widget - $e");
            throw Exception("Error al capturar la imagen del widget $key: $e");
          }
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
          context.push('/print?images=$jsonEncodedList');
        } else {
          throw Exception("Error capturando las imágenes y navegando a la pantalla de impresión");
        }
      } catch (e) {
        String error = e.toString().replaceAll("Exception: ", "");
        showError(context, title: "Error", errorMessage: "Error al capturar las imágenes. $error");
      } finally {
        Navigator.pop(context);
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
        await showCustomModal(
          context,
          "Encienda el Bluetooth",
          "Por favor, active el Bluetooth para usar esta función.",
          "Continuar",
          () => Navigator.pop(context),
          paddingHorizontal: 75,
        );
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
          InkWell(
            onTap: navigateToPrintScreen,
            child: ButtonPrimary(validator: loadingPrint, title: "Imprimir"),
          ),
          Visibility(
            visible: listProducts.isNotEmpty,
            child: Column(
              children: [
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async => await cancelProcess(),
                  child: ButtonPrimary(
                    validator: validCancelProcess,
                    title: "Cancelar",
                    color: const Color(0xffC7C6C8),
                    secondary: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

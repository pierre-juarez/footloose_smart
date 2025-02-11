import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/floating_button.dart';
import 'package:footloose_tickets/presentation/widgets/scan/camera_container.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:footloose_tickets/presentation/widgets/scan/list_product_queue.dart';

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
    startCamera();
  }

  @override
  void dispose() {
    super.dispose();
    mobileScannerController.stop();
    mobileScannerController.dispose();
  }

  Future<void> startCamera() async {
    infoLog("Iniciando cámara");
    try {
      setState(() => isInit = false);
      await Future.delayed(const Duration(milliseconds: 10));
      await mobileScannerController.start();
    } catch (e) {
      errorLog("🚀 ~ Error al aperturar la cámara: $e");
    } finally {
      setState(() => isInit = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(listProductProvider)['products'] ?? [];

    List<EtiquetaModel> skusUnicos = list.toSet().toList();

    Widget? floatingOption = (list.isNotEmpty)
        ? FloatingButton(
            onPressed: () async => await appRouter.pushReplacement('/preview'),
            icon: Icons.label_important_outline_sharp,
          )
        : null;

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarCustom(title: "Impresión de Etiquetas"),
        backgroundColor: AppColors.bodyGray,
        floatingActionButton: floatingOption,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),
            CameraContainer(
              isInit: isInit,
              mobileScannerController: mobileScannerController,
              urlScan: widget.urlScan,
              typeRequest: widget.typeRequest,
            ),
            const SizedBox(height: 10.0),
            ListProductsQueue(list: list, skusUnicos: skusUnicos, ref: ref)
          ],
        ),
      ),
    );
  }
}

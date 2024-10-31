import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/config/helpers/overlay_top.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/native/platform_channel.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/selected_device_provider.dart';
import 'package:footloose_tickets/presentation/widgets/custom_modal.dart';
import 'package:footloose_tickets/presentation/widgets/print/list_devices_bluetooth.dart';
import 'package:footloose_tickets/presentation/widgets/print/loading_print.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img; // Alias 'img' para evitar conflictos
import 'package:footloose_tickets/presentation/widgets/floating_button.dart';

class PrintScreen extends ConsumerStatefulWidget {
  static const name = 'print-screen';

  const PrintScreen({
    super.key,
    required this.imagePrintsList,
  });

  final List<Map<String, dynamic>> imagePrintsList;

  @override
  PrintPageProductState createState() => PrintPageProductState();
}

class PrintPageProductState extends ConsumerState<PrintScreen> {
  bool loadingDevices = false;
  List<BluetoothInfo> _devices = [];
  bool loadingPrint = false;
  List<Uint8List?> resizedImagesBytes = []; // Para almacenar las imágenes redimensionadas

  @override
  void initState() {
    super.initState();
    getDevices(null);
    resizeAllImages();
  }

  Future<void> resizeAllImages() async {
    for (var item in widget.imagePrintsList) {
      Uint8List imageBytes = item['image'];
      img.Image? originalImage = img.decodeImage(imageBytes);
      if (originalImage == null) {
        resizedImagesBytes.add(null);
        continue;
      }

      img.Image resizedImage = img.copyResize(originalImage, width: 580, height: 420);

      setState(() {
        resizedImagesBytes.add(Uint8List.fromList(img.encodePng(resizedImage)));
      });
    }
  }

  Future<void> getDevices(BuildContext? context) async {
    try {
      setState(() => loadingDevices = true);
      List<BluetoothInfo> devices = [];

      await Future.delayed(const Duration(milliseconds: 300));

      if (await Permission.bluetooth.isGranted &&
          await Permission.bluetoothScan.isGranted &&
          await Permission.bluetoothConnect.isGranted) {
        // Permisos concedidos, procede a obtener dispositivos Bluetooth
        devices = await PrintBluetoothThermal.pairedBluetooths;
      } else {
        // Solicita los permisos necesarios
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetooth,
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
        ].request();

        // Verifica si los permisos fueron concedidos después de la solicitud
        if ((statuses[Permission.bluetooth]?.isGranted ?? false) &&
            (statuses[Permission.bluetoothScan]?.isGranted ?? false) &&
            (statuses[Permission.bluetoothConnect]?.isGranted ?? false)) {
          devices = await PrintBluetoothThermal.pairedBluetooths;
        } else {
          infoLog("Permisos de Bluetooth no concedidos");
        }
      }

      bool isVerify = await verifyBluetooth();

      if (isVerify) {
        setState(() => _devices = devices);
      } else {
        _devices = [];
        if (context == null && !context!.mounted) return;
        await showCustomModal(
          context,
          "Encienda el Bluetooth",
          "Por favor, active el Bluetooth para usar esta función.",
          "Continuar",
          () => Navigator.pop(context),
          paddingHorizontal: 75,
        );
      }
    } catch (e) {
      throw ErrorDescription("Error al obtener dispositivos: $e");
    } finally {
      setState(() => loadingDevices = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> resetProcess() async {
      ref.read(listProductProvider.notifier).deleteAllProducts();
      appRouter.go('/home', extra: {'replace': true});
    }

    Future<void> showMessageSuccess() async {
      Future.delayed(const Duration(milliseconds: 1000));
      if (!context.mounted) return;
      await showTopSnackBar(
        context,
        "Las impresiones han sido realizadas correctamente",
        Icons.check_circle_rounded,
        duration: const Duration(seconds: 5),
        function: () async => await resetProcess(),
      );
    }

    void printImage() async {
      BluetoothInfo? selectedDevice = ref.watch(selectedDeviceProvider);
      bool success = true; // Variable de control para verificar si todas las impresiones fueron exitosas

      setState(() => loadingPrint = true);
      try {
        if (selectedDevice == null) {
          throw ErrorDescription("No se ha seleccionado ninguna impresora");
        }

        // Itera a través de cada imagen y su número de impresiones para enviarlas a imprimir
        for (int i = 0; i < resizedImagesBytes.length; i++) {
          final imageBytes = resizedImagesBytes[i];
          final numberOfPrints = widget.imagePrintsList[i]['numberprints'];

          if (imageBytes != null) {
            await PlatformChannel().printImage(imageBytes, numberOfPrints);
          }
        }
      } catch (e) {
        success = false;
        if (!context.mounted) return;
        showError(context, title: "Error", errorMessage: e.toString());
      } finally {
        setState(() => loadingPrint = false);
        if (success) showMessageSuccess();
      }
    }

    return Scaffold(
      appBar: const AppBarCustom(title: "Buscar impresora"),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: (!loadingDevices)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dispositivos emparejados: ${_devices.length}",
                    style: robotoStyle(18, FontWeight.w500, Colors.black),
                  ),
                  const SizedBox(height: 8),
                  ListDevicesBluetooth(devices: _devices),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingButton(onPressed: () async => await getDevices(context), icon: FontAwesomeIcons.rotateRight),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(onTap: printImage, child: ButtonPrimary(validator: loadingPrint, title: "Imprimir")),
                ],
              )
            : const LoadingPrint(),
      ),
    );
  }
}

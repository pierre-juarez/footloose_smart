import 'dart:typed_data';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img; // Alias 'img' para evitar conflictos

class PrintScreen extends StatefulWidget {
  static const name = 'print-screen';

  const PrintScreen({
    super.key,
    required this.imageBytes,
  });

  final Uint8List imageBytes;

  @override
  State<PrintScreen> createState() => _PrintPageProductState();
}

class _PrintPageProductState extends State<PrintScreen> {
  String messageOfPrinters = "";
  // BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  bool loadingDevices = false;
  List<BluetoothInfo> _devices = [];
  BluetoothInfo? selectedDevice;
  bool loadingPrint = false;

  @override
  void initState() {
    super.initState();
    getDevices(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Busca y selecciona una impresora"),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: (!loadingDevices)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dispositivos conectados: ${_devices.length}",
                    style: robotoStyle(18, FontWeight.w500, Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _devices.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            PrintBluetoothThermal.connect(macPrinterAddress: _devices[index].macAdress).then((_) {
                              setState(() {
                                selectedDevice = _devices[index];
                              });
                            });
                          },
                          child: _CardPrint(
                            selectedDevice: selectedDevice,
                            devices: _devices,
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(onTap: _print, child: ButtonPrimary(validator: loadingPrint, title: "Imprimir")),
                  const SizedBox(height: 50)
                ],
              )
            : const _LoadingPrinters(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getDevices(context);
        },
        child: const Icon(FontAwesomeIcons.arrowsRotate),
      ),
    );
  }

  Future<void> getDevices(BuildContext? context) async {
    try {
      setState(() {
        loadingDevices = true;
        // selectedDevice = null;
      });
      List<BluetoothInfo> devices = [];

      await Future.delayed(const Duration(milliseconds: 500));

      // Verifica y solicita permisos de Bluetooth
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
          // Maneja la situación en que los permisos no fueron otorgados
          print("Permisos de Bluetooth no concedidos");
        }
      }

      bool isVerify = await verifyBluetooth();

      if (isVerify) {
        setState(() {
          _devices = devices;
        });
      } else {
        _devices = [];
        if (context != null) {
          showBluetoothDialog(context, () {
            Navigator.pop(context);
          });
        }
      }
      setState(() {
        loadingDevices = false;
      });
    } catch (e) {
      setState(() {
        loadingDevices = false;
      });
      print("🚀 ~  Error al obtener lista de dispositivos: $e");
    }
  }

  void _print() async {
    if (selectedDevice != null) {
      try {
        setState(() {
          loadingPrint = true;
        });

        CapabilityProfile profile = await CapabilityProfile.load();
        Generator generator = Generator(PaperSize.mm80, profile);
        List<int> bytes = [];
        img.Image? image = img.decodeImage(widget.imageBytes);
        // if (image != null) {
        //   bytes += generator.image(image);
        //   print("🚀 ~ file: print_screen.dart ~ line: 172 ~ TM_FUNCTION: ");
        // }

        bytes += generator.text("Test de impresión", styles: const PosStyles(bold: true, underline: true));

        bytes += generator.row([
          PosColumn(text: "Header 1", width: 4, styles: const PosStyles(bold: true, underline: false)),
          PosColumn(text: "Header 2", width: 4, styles: const PosStyles(bold: true, underline: false)),
          PosColumn(text: "Header 3", width: 4, styles: const PosStyles(bold: true, underline: false)),
        ]);

        print("🚀 ~ file: print_screen.dart ~ line: 176 ~ TM_FUNCTION: ");
        await PrintBluetoothThermal.writeBytes(bytes);
        print("🚀 ~ file: print_screen.dart ~ line: 178 ~ TM_FUNCTION: ");

        await Future.delayed(const Duration(seconds: 5));

        PrintBluetoothThermal.disconnect;

        // Verificar si ya existe una conexión y desconectar si es necesario
        // if (await bluetooth.isConnected ?? false) {
        //   print("Desconectando la conexión Bluetooth existente...");
        //   await bluetooth.disconnect();
        // }

        // print("Conectando al dispositivo Bluetooth...");
        // bool connected = await bluetooth.connect(selectedDevice!);

        // // Usar el valor devuelto por el Future
        // print("Conectado: $connected");

        setState(() {
          loadingPrint = false;
          selectedDevice = null;
        });
      } catch (e) {
        // Captura cualquier excepción
        print("🚀 ~ Error durante la impresión: $e");
        setState(() {
          loadingPrint = false;
        });
        showError(context, title: "Error", errorMessage: "Error al imprimir, comuníquese con soporte");
      } finally {
        // Asegúrate de intentar desconectar siempre en el bloque `finally`
        // if (await bluetooth.isConnected ?? false) {
        //   print("Desconectando el dispositivo al finalizar...");
        //   await bluetooth.disconnect();
        // }
      }
    } else {
      setState(() {
        loadingPrint = false;
      });
      showError(context, title: "Error", errorMessage: "Seleccione al menos una impresora");
    }
  }

  // void _print() async {
  //   if (selectedDevice != null) {
  //     try {
  //       setState(() {
  //         loadingPrint = true;
  //       });
  //       await bluetooth.connect(selectedDevice!);
  //       await Future.delayed(const Duration(milliseconds: 500));
  //       await bluetooth.printImageBytes(widget.imageBytes);
  //       await Future.delayed(const Duration(milliseconds: 500));
  //       await bluetooth.disconnect();
  //       setState(() {
  //         loadingPrint = false;
  //       });
  //     } catch (e) {
  //       setState(() {
  //         loadingPrint = false;
  //       });
  //       print("🚀 ~ Error al imprimir la etiqueta: $e");
  //       showError(context, title: "Error", errorMessage: "Error al imprimir, comuníquese con soporte");
  //     }
  //   } else {
  //     setState(() {
  //       loadingPrint = false;
  //     });
  //     showError(context, title: "Error", errorMessage: "Seleccione al menos una impresora");
  //   }
  // }
}

class _CardPrint extends StatelessWidget {
  const _CardPrint({
    required this.selectedDevice,
    required List<BluetoothInfo> devices,
    required this.index,
  }) : _devices = devices;

  final BluetoothInfo? selectedDevice;
  final List<BluetoothInfo> _devices;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (selectedDevice == _devices[index]) ? const Color.fromARGB(105, 58, 129, 230) : Colors.transparent,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.black.withOpacity(0.20)),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.print_outlined,
            color: Colors.black,
            size: 40.0,
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidgetInput(
                text: "${index + 1}.- ${_devices[index].name} ${(selectedDevice == _devices[index]) ? "(Conectado)" : ""}",
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.start,
              ),
              TextWidgetInput(
                text: "MAC: ${_devices[index].macAdress} }",
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
                textAlign: TextAlign.start,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _LoadingPrinters extends StatelessWidget {
  const _LoadingPrinters();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppTheme.colorPrimary),
          const SizedBox(height: 13),
          Text(
            "Buscando impresoras...",
            style: robotoStyle(15, FontWeight.w400, Colors.black),
          )
        ],
      ),
    );
  }
}

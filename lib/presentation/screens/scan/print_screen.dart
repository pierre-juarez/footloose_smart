import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';

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
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  bool loadingDevices = false;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? selectedDevice;
  bool loadingPrint = false;

  @override
  void initState() {
    super.initState();
    getDevices(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppTheme.backgroundColor,
        title: Text(
          "Busca y selecciona una impresora",
          style: robotoStyle(18, FontWeight.w400, Colors.white),
        ),
      ),
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
                            setState(() {
                              selectedDevice = _devices[index];
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
      });
      await Future.delayed(const Duration(milliseconds: 500));
      List<BluetoothDevice> devices = await bluetooth.getBondedDevices();

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
        await bluetooth.connect(selectedDevice!);
        await bluetooth.printImageBytes(widget.imageBytes);
        await bluetooth.disconnect();
        setState(() {
          loadingPrint = false;
        });
      } catch (e) {
        setState(() {
          loadingPrint = false;
        });
        print("🚀 ~ Error al imprimir la etiqueta: $e");
        showError(context, title: "Error", errorMessage: "Error al imprimir, comuníquese con soporte");
      }
    } else {
      setState(() {
        loadingPrint = false;
      });
      showError(context, title: "Error", errorMessage: "Seleccione al menos una impresora");
    }
  }
}

class _CardPrint extends StatelessWidget {
  const _CardPrint({
    required this.selectedDevice,
    required List<BluetoothDevice> devices,
    required this.index,
  }) : _devices = devices;

  final BluetoothDevice? selectedDevice;
  final List<BluetoothDevice> _devices;
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
                text: "${index + 1}.- ${_devices[index].name} ${(selectedDevice == _devices[index]) ? "(Seleccionado)" : ""}",
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.start,
              ),
              TextWidgetInput(
                text: "MAC: ${_devices[index].address} - ${_devices[index].connected}",
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
          CircularProgressIndicator(color: AppTheme.colorSecondary),
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

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';
// import 'package:footloose_puntodeventa/src/helpers/bluetooth_validate.dart';
// import 'package:footloose_puntodeventa/src/ui/common/style.dart';
// import 'package:footloose_puntodeventa/src/ui/common/textStyle.dart';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:footloose_puntodeventa/src/ui/detail/pages/preview_page.dart';

class PrintScreen extends StatefulWidget {
  static const name = 'print-screen';

  const PrintScreen({
    super.key,
  });

  @override
  State<PrintScreen> createState() => _PrintPageProductState();
}

class _PrintPageProductState extends State<PrintScreen> {
  String messageOfPrinters = "";
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  bool loadingDevices = false;
  List<BluetoothDevice> _devices = [];

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
        title: const TextWidgetInput(
            text: "Buscar y seleccionar impresora",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            textAlign: TextAlign.start),
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidgetInput(
                text: messageOfPrinters,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.start),
            (!loadingDevices)
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 400.0,
                    child: ListView.builder(
                      itemCount: _devices.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print("🚀 ~ file: home_screen.dart ~ line: 70 ~ TM_FUNCTION: ");
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => PreviewPrintPage(
                            //         //printerBluetooth: selectPrinterBluethoo,
                            //         ),
                            //   ),
                            // );
                          },
                          child: Container(
                            decoration: BoxDecoration(
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
                                        text: _devices[index].name ?? "-",
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        textAlign: TextAlign.start),
                                    TextWidgetInput(
                                        text:
                                            "${_devices[index].address} - ${_devices[index].connected} - ${_devices[index].type}",
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                        textAlign: TextAlign.start)
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 13,
                      ),
                      Text("Buscando impresoras...")
                    ],
                  )
          ],
        ),
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

      print("🚀 ~ file: home_screen.dart ~ line: 153 ~ TM_FUNCTION: $isVerify");

      if (isVerify) {
        setState(() {
          _devices = devices;
        });
      } else {
        _devices = [];
        if (context != null) {
          showBluetoothDialog(context, () {
            Navigator.pop(context);
            // Navigator.pop(context);
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
      print("🚀 ~ file: print_page.dart ~ line: 153 ~ Error al obtener lista de dispositivos: $e");
    }
  }
}

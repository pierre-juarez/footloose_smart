import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:permission_handler/permission_handler.dart';

BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
bool connected = false;

Future<bool> requestPermissions() async {
  var status = await [
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
    Permission.location,
  ].request();

  return (status[Permission.bluetooth]!.isGranted &&
      status[Permission.bluetoothConnect]!.isGranted &&
      status[Permission.bluetoothScan]!.isGranted &&
      status[Permission.location]!.isGranted);
}

Future<bool> verifyBluetooth() async {
  bool isPermissions = await requestPermissions();

  if (isPermissions) {
    Completer<bool> completer = Completer<bool>();

    StreamSubscription? subscription;
    subscription = bluetooth.onStateChanged().listen(
      (state) {
        switch (state) {
          case BlueThermalPrinter.CONNECTED:
            connected = true;
            infoLog("Bluetooth device state: connected");
            break;
          case BlueThermalPrinter.DISCONNECTED:
            connected = false;
            infoLog("Bluetooth device state: disconnected");
            break;
          case BlueThermalPrinter.DISCONNECT_REQUESTED:
            connected = false;
            infoLog("Bluetooth device state: disconnect requested");
            break;
          case BlueThermalPrinter.STATE_TURNING_OFF:
            connected = false;
            infoLog("Bluetooth device state: bluetooth turning off");
            break;
          case BlueThermalPrinter.STATE_OFF:
            connected = false;
            infoLog("Bluetooth device state: bluetooth off");
            break;
          case BlueThermalPrinter.STATE_ON:
            connected = true;
            infoLog("Bluetooth device state: bluetooth on");
            break;
          case BlueThermalPrinter.STATE_TURNING_ON:
            connected = false;
            infoLog("Bluetooth device state: bluetooth turning on");
            break;
          case BlueThermalPrinter.ERROR:
            connected = false;
            infoLog("Bluetooth device state: error");
            break;
          default:
            infoLog(state.toString());
            break;
        }
        if (!completer.isCompleted) {
          completer.complete(connected);
        }
        subscription?.cancel();
      },
    );

    bool result = await completer.future;
    return result;
  } else {
    return false;
  }
}

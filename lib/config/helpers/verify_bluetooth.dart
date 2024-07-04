import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';
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

  if (status[Permission.bluetooth]!.isGranted &&
      status[Permission.bluetoothConnect]!.isGranted &&
      status[Permission.bluetoothScan]!.isGranted &&
      status[Permission.location]!.isGranted) {
    print("All permissions granted");
    return true;
  } else {
    print("Permissions not granted");
    return false;
  }
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
            print("bluetooth device state: connected");
            break;
          case BlueThermalPrinter.DISCONNECTED:
            connected = false;
            print("bluetooth device state: disconnected");
            break;
          case BlueThermalPrinter.DISCONNECT_REQUESTED:
            connected = false;
            print("bluetooth device state: disconnect requested");
            break;
          case BlueThermalPrinter.STATE_TURNING_OFF:
            connected = false;
            print("bluetooth device state: bluetooth turning off");
            break;
          case BlueThermalPrinter.STATE_OFF:
            connected = false;
            print("bluetooth device state: bluetooth off");
            break;
          case BlueThermalPrinter.STATE_ON:
            connected = true;
            print("bluetooth device state: bluetooth on");
            break;
          case BlueThermalPrinter.STATE_TURNING_ON:
            connected = false;
            print("bluetooth device state: bluetooth turning on");
            break;
          case BlueThermalPrinter.ERROR:
            connected = false;
            print("bluetooth device state: error");
            break;
          default:
            print(state);
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

Future<void> showBluetoothDialog(BuildContext context, VoidCallback? onTap) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Encienda el Bluetooth',
        style: robotoStyle(20, FontWeight.w600, Colors.black),
      ),
      content: Text(
        'Por favor, active el Bluetooth para usar esta función.',
        style: robotoStyle(16, FontWeight.normal, Colors.black),
      ),
      actions: <Widget>[
        InkWell(
          onTap: (onTap != null)
              ? onTap
              : () {
                  Navigator.pop(context);
                },
          child: ButtonPrimary(
            validator: false,
            title: "OK",
            type: "small",
            color: AppTheme.colorPrimary,
          ),
        )
      ],
    ),
  );
}

Future<void> showOptions(BuildContext context, AuthProvider auth) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Cerrar sesión',
        style: robotoStyle(20, FontWeight.w600, Colors.black),
      ),
      content: Text(
        '¿Está seguro que desea cerrar sesión?',
        style: robotoStyle(16, FontWeight.normal, Colors.black),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  auth.clearInputs();
                  await auth.logout();
                  redirectToPage("/");
                },
                child: const ButtonPrimary(
                  validator: false,
                  title: "Cerrar sesión",
                  type: "small",
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: ButtonPrimary(
                  validator: false,
                  title: "Cancelar",
                  type: "small",
                  color: AppTheme.colorSecondary,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/widgets/scan/card_print.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class ListDevicesBluetooth extends StatelessWidget {
  const ListDevicesBluetooth({
    super.key,
    required List<BluetoothInfo> devices,
  }) : _devices = devices;

  final List<BluetoothInfo> _devices;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ListView.builder(
            itemCount: _devices.length,
            itemBuilder: (context, index) {
              return CardPrint(devices: _devices, index: index);
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/product/print_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/selected_device_provider.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class CardPrintDetail extends ConsumerWidget {
  const CardPrintDetail({
    super.key,
    required List<BluetoothInfo> devices,
    required this.index,
  }) : _devices = devices;

  final List<BluetoothInfo> _devices;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoxDecoration? decoration;
    Color? colorLoading;
    final loadingConnect = ref.watch(printProvider);
    final selectedDevice = ref.watch(selectedDeviceProvider);

    if (selectedDevice?.macAdress == _devices[index].macAdress) {
      decoration = BoxDecoration(
        color: AppTheme.colorPrimary.withOpacity(0.4),
        border: Border.all(color: AppTheme.colorPrimary, width: 2),
        borderRadius: BorderRadius.circular(15),
      );
    } else {
      decoration = BoxDecoration(
        color: (loadingConnect) ? Colors.grey.withOpacity(0.1) : Colors.transparent,
      );
      colorLoading = loadingConnect ? Colors.grey.withOpacity(0.7) : Colors.black;
    }

    return Column(
      children: [
        Container(
          decoration: decoration,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.print_outlined,
                color: colorLoading,
                size: 40.0,
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidgetInput(
                    text:
                        "${index + 1}.- ${_devices[index].name} ${(selectedDevice?.macAdress == _devices[index].macAdress) ? "(Conectado)" : ""}",
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: colorLoading ?? Colors.black,
                    textAlign: TextAlign.start,
                  ),
                  TextWidgetInput(
                    text: "MAC: ${_devices[index].macAdress}",
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: colorLoading ?? Colors.black,
                    textAlign: TextAlign.start,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

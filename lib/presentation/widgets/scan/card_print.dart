import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/overlay_top.dart';
import 'package:footloose_tickets/native/platform_channel.dart';
import 'package:footloose_tickets/presentation/providers/product/print_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/selected_device_provider.dart';
import 'package:footloose_tickets/presentation/widgets/scan/card_print_detail.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class CardPrint extends ConsumerStatefulWidget {
  const CardPrint({
    super.key,
    required List<BluetoothInfo> devices,
    required this.index,
  }) : _devices = devices;

  final List<BluetoothInfo> _devices;
  final int index;

  @override
  CardPrintState createState() => CardPrintState();
}

class CardPrintState extends ConsumerState<CardPrint> {
  bool _loadingConnect = false;

  @override
  Widget build(BuildContext context) {
    final stateLoadingConnect = ref.watch(printProvider);

    void setLoadingState(bool isLoading) {
      setState(() {
        _loadingConnect = isLoading;
      });
    }

    Future<void> connectDevice(BluetoothInfo device) async {
      ref.read(printProvider.notifier).startLoading();
      ref.read(selectedDeviceProvider.notifier).resetDevice();
      setLoadingState(true);
      try {
        await PlatformChannel().connectToDevice(device.macAdress);
        ref.read(selectedDeviceProvider.notifier).selectedDevice(device);
        showTopSnackBar(context, "Impresora conectada", Icons.info_outline_rounded);
      } catch (e) {
        showError(context, title: "Error", errorMessage: "Error al conectar la impresora - ${e.toString()}");
        ref.read(selectedDeviceProvider.notifier).resetDevice();
      } finally {
        ref.read(printProvider.notifier).stopLoading();
        setLoadingState(false);
      }
    }

    return AbsorbPointer(
      absorbing: stateLoadingConnect,
      child: Column(
        children: [
          (_loadingConnect)
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 20, top: 15),
                    child: const SizedBox(height: 30, width: 30, child: CircularProgressIndicator()),
                  ),
                )
              : InkWell(
                  onTap: () async => await connectDevice(widget._devices[widget.index]),
                  child: CardPrintDetail(
                    devices: widget._devices,
                    index: widget.index,
                  ),
                ),
          (widget.index != widget._devices.length - 1) ? Divider(color: Colors.black.withOpacity(0.20)) : Container()
        ],
      ),
    );
  }
}

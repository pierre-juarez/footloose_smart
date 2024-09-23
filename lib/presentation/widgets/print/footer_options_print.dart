import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/overlay_top.dart';
import 'package:footloose_tickets/native/platform_channel.dart';
import 'package:footloose_tickets/presentation/providers/product/selected_device_provider.dart';

class FooterOptionsPrint extends ConsumerStatefulWidget {
  const FooterOptionsPrint({
    super.key,
    required this.refresh,
  });

  final Future<void> Function(BuildContext context) refresh;

  @override
  FooterOptionsPrintState createState() => FooterOptionsPrintState();
}

class FooterOptionsPrintState extends ConsumerState<FooterOptionsPrint> {
  @override
  Widget build(BuildContext context) {
    Future<void> disconnectDevice() async {
      try {
        await PlatformChannel().disconnectDevice();
        ref.read(selectedDeviceProvider.notifier).resetDevice();
        if (!context.mounted) return;
        showTopSnackBar(context, "Impresora desconectada", Icons.info_outline);
      } catch (e) {
        showError(context, title: "Error", errorMessage: "Error al desconectar la impresora - ${e.toString()}");
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Ajusta la alineación
        children: [
          Visibility(
            visible: ref.watch(selectedDeviceProvider) != null,
            child: FloatingActionButton(
              heroTag: 'btnDisconnect',
              onPressed: () async => await disconnectDevice(),
              child: const Icon(Icons.bluetooth_disabled),
            ),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'btnRefresh',
            onPressed: () async => await widget.refresh(context),
            child: const Icon(FontAwesomeIcons.arrowsRotate),
          ),
        ],
      ),
    );
  }
}

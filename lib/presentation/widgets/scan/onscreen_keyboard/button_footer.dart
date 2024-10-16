import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/presentation/providers/product/sku_search_provider.dart';
import 'package:footloose_tickets/presentation/widgets/scan/button_outline.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ButtonFooter extends ConsumerWidget {
  final MobileScannerController mobileScannerController;

  const ButtonFooter({super.key, required this.mobileScannerController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skuSearchMethods = ref.watch(skuSearchProvider.notifier);

    Future<void> scanWithCamera() async {
      Navigator.pop(context);
      skuSearchMethods.resetSkuSearch();
      await mobileScannerController.start();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.48,
          child: ButtonOutline(
            title: 'Cancelar',
            callback: () async => await scanWithCamera(),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.48,
          child: ButtonOutline(
            title: 'Ingresar con cámara',
            callback: () async => await scanWithCamera(),
          ),
        )
      ],
    );
  }
}

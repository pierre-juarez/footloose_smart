import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/scan/onscreen_keyboard/button_center.dart';
import 'package:footloose_tickets/presentation/widgets/scan/onscreen_keyboard/button_footer.dart';
import 'package:footloose_tickets/presentation/widgets/scan/onscreen_keyboard/header_keyboard.dart';
import 'package:footloose_tickets/presentation/widgets/scan/onscreen_keyboard/keyboard.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class OnscreenKeyboard extends StatelessWidget {
  const OnscreenKeyboard({
    super.key,
    required this.mobileScannerController,
    required this.urlScan,
    required this.typeRequest,
  });
  static const name = "keyboard-screen";

  final MobileScannerController mobileScannerController;
  final String urlScan;
  final String typeRequest;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bodyGray,
          body: Container(
            margin: const EdgeInsets.only(top: 6, right: 6, left: 6, bottom: 6),
            decoration: BoxDecoration(color: AppColors.textLight, borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeaderKeyboard(),
                  Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Keyboard(),
                          ButtonCenter(urlScan: urlScan, typeRequest: typeRequest),
                          ButtonFooter(mobileScannerController: mobileScannerController),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

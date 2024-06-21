import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraProvider with ChangeNotifier {
  MobileScannerController _mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      autoStart: false,
      formats: [BarcodeFormat.code128, BarcodeFormat.code39, BarcodeFormat.all]);

  MobileScannerController get mobileScannerController => _mobileScannerController;
  set mobileScannerController(MobileScannerController valor) {
    _mobileScannerController = valor;
    notifyListeners();
  }
}

final cameraProvider = ChangeNotifierProvider((ref) => CameraProvider());

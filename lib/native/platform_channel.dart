import 'package:flutter/services.dart';

class PlatformChannel {
  static const MethodChannel _channelBluetooth = MethodChannel('app.footloose_tickets/bluetooth');

  Future<void> connectToDevice(String macAddress) async {
    try {
      await _channelBluetooth.invokeMethod('connect', {'mac': macAddress});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> disconnectDevice() async {
    try {
      await _channelBluetooth.invokeMethod('disconnect');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> printImage(Uint8List image, int numberOfPrints) async {
    try {
      await _channelBluetooth.invokeMethod('printImage', {'image': image, 'numberPrints': numberOfPrints});
    } catch (e) {
      rethrow;
    }
  }
}

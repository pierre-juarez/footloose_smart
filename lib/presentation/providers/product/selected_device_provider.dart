import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class SelectedDeviceProvider extends StateNotifier<BluetoothInfo?> {
  SelectedDeviceProvider() : super(null);

  void selectedDevice(BluetoothInfo? device) {
    state = device;
  }

  void resetDevice() {
    state = null;
  }
}

final selectedDeviceProvider = StateNotifierProvider<SelectedDeviceProvider, BluetoothInfo?>(
  (ref) => SelectedDeviceProvider(),
);

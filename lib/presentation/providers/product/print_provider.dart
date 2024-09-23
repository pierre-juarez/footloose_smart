import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrintProvider extends StateNotifier<bool> {
  PrintProvider() : super(false);

  void startLoading() {
    state = true;
  }

  void stopLoading() {
    state = false;
  }
}

final printProvider = StateNotifierProvider<PrintProvider, bool>(
  (ref) => PrintProvider(),
);

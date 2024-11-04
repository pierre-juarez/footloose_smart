import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnifiedLabelProvider extends StateNotifier<String> {
  UnifiedLabelProvider() : super("");

  void setUnifiedLabel(String unifiedLabel) {
    state = unifiedLabel;
  }

  void resetLabel() {
    state = "";
  }
}

final unifiedLabelProvider = StateNotifierProvider<UnifiedLabelProvider, String>((ref) => UnifiedLabelProvider());

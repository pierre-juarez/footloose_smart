import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/infraestructure/models/selection_pais_model.dart';

class SelectedOptionNotifier extends StateNotifier<SelectedPais> {
  SelectedOptionNotifier() : super(SelectedPais(option: "", optionId: ""));

  void selectOption(String option, String optionId) {
    state = SelectedPais(option: option, optionId: optionId);
  }

  void resetSelection() {
    state = SelectedPais(option: "", optionId: "");
  }
}

final selectedOptionProvider = StateNotifierProvider<SelectedOptionNotifier, SelectedPais>((ref) {
  return SelectedOptionNotifier();
});

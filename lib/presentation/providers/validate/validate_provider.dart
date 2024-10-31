import 'package:flutter_riverpod/flutter_riverpod.dart';

class ValidateProvider extends StateNotifier<bool> {
  ValidateProvider() : super(false);

  void statusValidate(bool status) {
    state = status;
  }
}

final validateProvider = StateNotifierProvider<ValidateProvider, bool>((ref) {
  return ValidateProvider();
});

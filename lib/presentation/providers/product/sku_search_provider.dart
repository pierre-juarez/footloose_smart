import 'package:flutter_riverpod/flutter_riverpod.dart';

class SkuSearchProvider extends StateNotifier<String> {
  SkuSearchProvider() : super('');

  void setSkuSearch(String skuSearch) {
    state = state + skuSearch;
  }

  getSkuSearch<String>() {
    return state;
  }

  void resetSkuSearch() {
    state = '';
  }

  void deleteItem() {
    if (state.length == 1) {
      state = "";
    } else {
      state = state.substring(0, state.length - 1);
    }
  }

  void typeItem(item) {
    if (state.length < 11 && item != "c") {
      state = state + item;
    } else if (item == "c") {
      state = "";
    }
  }
}

final skuSearchProvider = StateNotifierProvider<SkuSearchProvider, String>(
  (ref) => SkuSearchProvider(),
);

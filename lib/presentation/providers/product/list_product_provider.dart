import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';

class ListProductProvider extends StateNotifier<Map<String, List<EtiquetaModel>>> {
  ListProductProvider() : super({});

  void saveProduct(EtiquetaModel product) {
    List<EtiquetaModel> products = state["products"] ?? [];
    products = [...products, product];
    state = {...state, "products": products};
  }

  void deleteProduct(String sku) {
    List<EtiquetaModel> products = state["products"] ?? [];
    products.removeWhere((product) => product.sku == sku);
    state = {...state, "products": products};
  }

  void deleteAllProducts() {
    state = {...state, "products": []};
  }
}

final listProductProvider = StateNotifierProvider<ListProductProvider, Map<String, List<EtiquetaModel>>>(
  (ref) => ListProductProvider(),
);

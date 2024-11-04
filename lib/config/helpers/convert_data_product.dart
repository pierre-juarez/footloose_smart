import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/unified_label_provider.dart';
import 'package:uuid/uuid.dart';

Future<EtiquetaModel> convertDataProduct(ProductDetailModel productDetail, BuildContext context, WidgetRef ref) async {
  final config = ref.read(configurationProvider);

  if (productDetail.productDetail == null) {
    showError(context, title: "Error", errorMessage: "Datos de producto inválidos");
    return EtiquetaModel.empty();
  }

  final productData = productDetail.productDetail!;

  final String temporada = productData.temporada;
  final String tipoArticulo = productData.tipoDeArticulo ?? "-";
  final String material = "${productData.material1} ${productData.material2} ${productData.material3}";
  final String nombre = productData.nombre;
  final String sku = productData.producto;
  final double pvp = productData.preciobancoCiva;
  final String talla = productData.tallas;
  final String fechaCreacion = formatDate(productData.fechacompra);
  final String marca = productData.marca;
  final String modelo = productData.modelo;
  final String imgUrl = productData.urlimagen;
  final String color = productData.color1.toString();

  final List<String> splitNombre = nombre.split(" ");
  final String abrev = (splitNombre.length > 4) ? splitNombre[4] : "-";

  final String configID = await config.getConfigId();
  final String formattedPrice = "${configID == "1" ? "S/." : "\$/."} $pvp"; // Configuration type money

  String unifiedLabel = ref.read(unifiedLabelProvider);

  EtiquetaModel etiqueta = EtiquetaModel(
    id: const Uuid().v4(),
    nombre: nombre,
    marcaAbrev: "$marca - $abrev",
    tipoArticulo: tipoArticulo,
    modelo: modelo,
    color: color,
    material: material.trim(),
    precio: formattedPrice,
    talla: talla,
    sku: unifiedLabel.isNotEmpty ? unifiedLabel : sku,
    cu: "cu",
    fechaCreacion: fechaCreacion,
    temporada: temporada,
    imageUrl: imgUrl,
    abrev: abrev,
    marca: marca,
    numberOfPrints: 2,
  );

  final list = ref.watch(listProductProvider)['products'] ?? [];
  bool exists = list.any((p) => p.sku == etiqueta.sku);

  EtiquetaModel etiquetaReturn = EtiquetaModel.empty();

  if (!exists) {
    ref.read(listProductProvider.notifier).saveProduct(etiqueta);
    etiquetaReturn = etiqueta;
  } else {
    if (!context.mounted) return etiquetaReturn;
    showError(context, title: "Error", errorMessage: "El producto ya ha sido agregado a la fila");
  }
  ref.read(unifiedLabelProvider.notifier).resetLabel();
  return etiquetaReturn;
}

String convertToUnifiedLabel(String sku) => (sku.length == 23) ? sku.substring(0, 11) : sku;

String convertSkuToUnifiedLabel(String sku) => (sku.length == 23) ? sku.substring(11) : sku;

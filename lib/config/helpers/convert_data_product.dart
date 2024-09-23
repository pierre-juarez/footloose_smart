import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:uuid/uuid.dart';

Future<EtiquetaModel> convertDataProduct(ProductDetailModel productDetail, BuildContext context, WidgetRef ref) async {
  final config = ref.read(configurationProvider);
  final productData = productDetail.data?.first;

  if (productData == null) {
    showError(context, title: "Error", errorMessage: "Datos de producto inválidos");
    return EtiquetaModel.empty();
  }

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
    sku: sku,
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

  if (!exists) {
    ref.read(listProductProvider.notifier).saveProduct(etiqueta);
    return etiqueta;
  } else {
    if (!context.mounted) return EtiquetaModel.empty();
    showError(context, title: "Error", errorMessage: "El producto ya ha sido agregado a la fila");
    return EtiquetaModel.empty();
  }
}

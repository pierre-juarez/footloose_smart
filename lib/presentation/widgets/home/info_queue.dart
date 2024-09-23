import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';

class InfoQueue extends StatelessWidget {
  const InfoQueue({
    super.key,
    required this.listProducts,
    required this.countItems,
    required this.countProducts,
  });

  final List<EtiquetaModel> listProducts;
  final int countItems;
  final int countProducts;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: listProducts.isNotEmpty,
      child: Column(
        children: [
          Text(
            "ítems en la fila: $countItems",
            style: robotoStyle(15, FontWeight.w600, Colors.black),
            textAlign: TextAlign.center,
          ),
          Text(
            "Productos en la fila: $countProducts",
            style: robotoStyle(15, FontWeight.w600, Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

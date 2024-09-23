import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/detail_product/card_temporada.dart';
import 'package:footloose_tickets/presentation/widgets/detail_product/image_found.dart';
import 'package:footloose_tickets/presentation/widgets/detail_product/image_not_found.dart';

class CardProduct extends StatelessWidget {
  final EtiquetaModel etiqueta;

  const CardProduct({
    super.key,
    required this.etiqueta,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTemporada(temporada: etiqueta.temporada),
              const SizedBox(height: 10),
              Text(
                "${etiqueta.tipoArticulo} / ${etiqueta.material} - ${etiqueta.color}",
                style: robotoStyle(13, FontWeight.w400, Colors.black),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: SizedBox(
                  height: 150.0,
                  child: (etiqueta.imageUrl.isNotEmpty) ? ImageFound(path: etiqueta.imageUrl) : const ImageNotFound(),
                ),
              ),
              const SizedBox(height: 15.0),
              Text(etiqueta.nombre),
              const SizedBox(height: 10),
              Text(etiqueta.marca),
              Text("${etiqueta.abrev} - ${etiqueta.modelo}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SKU: ${etiqueta.sku} - CU: ${etiqueta.cu}",
                        style: robotoStyle(15, FontWeight.w400, const Color(0xff666666)),
                      ),
                      Text(
                        etiqueta.precio,
                        style: robotoStyle(22, FontWeight.bold, AppTheme.colorPrimary),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      "Talla: ${etiqueta.talla}",
                      style: robotoStyle(15, FontWeight.w500, Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Text(
                "Fecha Creación: ${etiqueta.fechaCreacion}",
                style: robotoStyle(15, FontWeight.w400, Colors.black),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ],
    );
  }
}

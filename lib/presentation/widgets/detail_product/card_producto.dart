import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            boxShadow: AppStyles.shadowCard,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.textLight,
          ),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTemporada(temporada: etiqueta.temporada),
              const SizedBox(height: 8),
              Text(
                "${etiqueta.tipoArticulo} / ${etiqueta.material} - ${etiqueta.color}",
                style: AppTextStyles.displayTextCaptionInfoProduct,
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  height: 150.0,
                  child: (etiqueta.imageUrl.isNotEmpty) ? ImageFound(path: etiqueta.imageUrl) : const ImageNotFound(),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      etiqueta.nombre,
                      style: AppTextStyles.displayTextBoldInfoProduct,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      etiqueta.marca,
                      style: AppTextStyles.displayTextCaptionInfoProduct,
                    ),
                    Text(
                      "${etiqueta.abrev} - ${etiqueta.modelo}",
                      style: AppTextStyles.displayTextCaptionInfoProduct,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SKU: ${etiqueta.sku}",
                              style: robotoStyle(15, FontWeight.w400, const Color(0xff666666)),
                            ),
                            Text(
                              etiqueta.precio,
                              style: robotoStyle(22, FontWeight.bold, AppColors.primaryMain),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(color: AppColors.primaryDarkCard, borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            "Talla: ${etiqueta.talla}",
                            style: robotoStyle(15, FontWeight.w500, AppColors.textLight),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "Fecha Creación: ${formatDateString(etiqueta.fechaCreacion)}",
                      style: robotoStyle(15, FontWeight.w400, Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

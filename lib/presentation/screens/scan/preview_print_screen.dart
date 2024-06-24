import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/navbar.dart';

class PreviewPrintScreen extends StatelessWidget {
  static const name = "preview-print-screen";
  const PreviewPrintScreen({
    super.key,
    required this.etiqueta,
  });

  final EtiquetaModel etiqueta;
  @override
  Widget build(BuildContext context) {
    final barcode = Barcode.code128();
    final svg = barcode.toSvg("${etiqueta.sku}${etiqueta.sku}", width: 400, height: 150);

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          NavbarHome(
            title: "Previsualización de etiqueta",
            onTap: () {
              //
            },
          ),
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(border: Border.all(color: AppTheme.colorSecondary, width: 2)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextDescription(description: etiqueta.marcaAbrev),
                              TextDescription(description: etiqueta.tipoArticulo),
                              TextDescription(description: etiqueta.modelo),
                              TextDescription(description: etiqueta.color),
                              TextDescription(description: etiqueta.material),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                etiqueta.precio,
                                style: robotoStyle(19, FontWeight.w500, Colors.black),
                              ),
                              TextDescription(description: etiqueta.talla),
                              Row(
                                children: [
                                  Text("SKU:", style: robotoStyle(15, FontWeight.w900, Colors.black)),
                                  Text(
                                    etiqueta.sku,
                                    style: robotoStyle(18, FontWeight.w500, Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SvgPicture.string(
                        svg,
                        fit: BoxFit.contain,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextDescription(description: etiqueta.fechaCreacion),
                          TextDescription(description: etiqueta.temporada),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: InkWell(
                      onTap: () {
                        print("🚀 ~ file: preview_print_screen.dart ~ line: 95 ~ TM_FUNCTION: ");
                      },
                      child: const ButtonPrimary(validator: false, title: "Imprimir")),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class TextDescription extends StatelessWidget {
  const TextDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(description, style: robotoStyle(15, FontWeight.w500, Colors.black));
  }
}

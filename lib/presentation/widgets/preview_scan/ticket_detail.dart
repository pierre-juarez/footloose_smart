import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:footloose_tickets/config/helpers/convert_data_product.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/scan/ticket_description.dart';

class TicketDetail extends StatelessWidget {
  const TicketDetail({
    super.key,
    required this.etiqueta,
    required this.svg,
  });

  final EtiquetaModel etiqueta;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TicketDescription(description: etiqueta.marcaAbrev),
                      TicketDescription(description: etiqueta.tipoArticulo),
                      TicketDescription(description: etiqueta.modelo),
                      Row(
                        children: [
                          TicketDescription(description: etiqueta.color),
                          TicketDescription(description: etiqueta.material),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        etiqueta.precio,
                        style: robotoStyle(19, FontWeight.w500, Colors.black),
                      ),
                      TicketDescription(description: etiqueta.talla),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("SKU:", style: robotoStyle(13.5, FontWeight.w900, Colors.black)),
                          Text(
                            convertToUnifiedLabel(etiqueta.sku),
                            style: robotoStyle(15, FontWeight.w500, Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 0, left: 7, top: 5, bottom: 15),
                child: SvgPicture.string(svg, fit: BoxFit.contain),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Text(
                    convertSkuToUnifiedLabel(etiqueta.sku),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TicketDescription(description: etiqueta.fechaCreacion),
                TicketDescription(description: etiqueta.temporada),
              ],
            ),
          )
        ],
      ),
    );
  }
}

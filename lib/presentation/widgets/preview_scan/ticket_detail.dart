import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      color: Colors.blue,
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      // padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
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
                  width: MediaQuery.of(context).size.width * 0.3,
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
                            etiqueta.sku,
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
          Container(
            color: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: SvgPicture.string(svg, fit: BoxFit.contain),
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

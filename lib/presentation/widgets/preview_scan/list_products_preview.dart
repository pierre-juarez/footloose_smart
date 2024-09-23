
import 'package:flutter/material.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/preview_scan/ticket_detail.dart';

class ListProductsPreview extends StatelessWidget {
  const ListProductsPreview({
    super.key,
    required this.listProducts,
    required List<GlobalKey<State<StatefulWidget>>> globalKeys,
    required this.svgs,
  }) : _globalKeys = globalKeys;

  final List<EtiquetaModel> listProducts;
  final List<GlobalKey<State<StatefulWidget>>> _globalKeys;
  final List<String> svgs;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemCount: listProducts.length,
            itemBuilder: (context, indexList) {
              if (_globalKeys.isNotEmpty) {
                final etiqueta = listProducts[indexList];
                final svg = svgs[indexList];
                final titleText =
                    "${indexList + 1}.- SKU: ${etiqueta.sku} - ${etiqueta.modelo} - ${etiqueta.numberOfPrints} etiqueta${(etiqueta.numberOfPrints) > 1 ? "s" : ""}";
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titleText),
                      RepaintBoundary(
                        key: _globalKeys[indexList],
                        child: TicketDetail(etiqueta: etiqueta, svg: svg),
                      )
                    ],
                  ),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}



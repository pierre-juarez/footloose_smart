import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/convert_data_product.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/preview_scan/ticket_detail.dart';

class ListProductsPreview extends StatelessWidget {
  const ListProductsPreview({
    super.key,
    required this.listProducts,
    required List<GlobalKey<State<StatefulWidget>>> globalKeys,
    required this.svgs,
    required this.scrollController,
  }) : _globalKeys = globalKeys;

  final List<EtiquetaModel> listProducts;
  final List<GlobalKey<State<StatefulWidget>>> _globalKeys;
  final List<String> svgs;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: listProducts.length,
            itemBuilder: (context, indexList) {
              print("🚀 ~ file: list_products_preview.dart ~ line: 32 ~ TM_FUNCTION: SVG's: ${svgs.length} -  index: $indexList");
              if (_globalKeys.isNotEmpty) {
                final etiqueta = listProducts[indexList];
                final svg = svgs[indexList]; // REVIEW - RangeError (length): Invalid value: Only valid value is 0: 1
                final titleText =
                    "${indexList + 1}.- SKU: ${convertToUnifiedLabel(etiqueta.sku)} - ${etiqueta.modelo} - ${etiqueta.numberOfPrints} etiqueta${(etiqueta.numberOfPrints) > 1 ? "s" : ""}";
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleText),
                    RepaintBoundary(
                      key: _globalKeys[indexList],
                      child: TicketDetail(etiqueta: etiqueta, svg: svg),
                    )
                  ],
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

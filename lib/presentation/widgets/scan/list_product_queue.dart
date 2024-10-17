import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/scan/dismissible_row_product.dart';

class ListProductsQueue extends ConsumerStatefulWidget {
  const ListProductsQueue({
    super.key,
    required this.list,
    required this.skusUnicos,
    required this.ref,
  });

  final List<EtiquetaModel> list;
  final List<EtiquetaModel> skusUnicos;
  final WidgetRef ref;

  @override
  ListProductsQueueState createState() => ListProductsQueueState();
}

class ListProductsQueueState extends ConsumerState<ListProductsQueue> {
  @override
  Widget build(BuildContext context) {
    Future<void> deleteAllItems() async {
      deleteAllItemsQueue(ref, context, () => setState(() {}));
    }

// FIXME - Error al visualizar productos en cola
    return Visibility(
      visible: widget.list.isNotEmpty,
      child: Expanded(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text(
                    "Productos en cola: ${widget.skusUnicos.length}",
                    style: robotoStyle(18, FontWeight.bold, Colors.black).copyWith(decoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("(Desliza a la izquierda para eliminar)"),
                      InkWell(
                        onTap: () async => deleteAllItems(),
                        child: Text(
                          "Vaciar todo",
                          style: robotoStyle(15, FontWeight.bold, Colors.red),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: widget.skusUnicos.length,
                      itemBuilder: (context, index) {
                        final product = widget.skusUnicos[index];
                        return DismissibleRowProduct(product: product, ref: widget.ref, index: index);
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Productos en Cola (${widget.skusUnicos.length})",
                        style: AppTextStyles.displayTitleModalPais,
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () async => deleteAllItems(),
                        child: Text(
                          "Eliminar todo",
                          style: robotoStyle(16, FontWeight.bold, const Color(0xffE73743)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 160,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

class DismissibleRowProduct extends StatelessWidget {
  const DismissibleRowProduct({
    super.key,
    required this.product,
    required this.ref,
    required this.index,
  });

  final EtiquetaModel product;
  final WidgetRef ref;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(product.sku),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        bool deleteConfirmed = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return PopScope(
              canPop: false,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                                      color: const Color(0xffFAFAFA),
                                      border: Border.all(color: AppColors.bodySecondaryButton, width: 0.6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Confirmación",
                                        style: AppTextStyles.displayTitleModalPais,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 30,
                                      left: 30,
                                      top: 16,
                                      bottom: 16,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          '¿Estás seguro de que quieres eliminar un producto del SKU: ${product.sku}?',
                                          style: AppTextStyles.displaySubtitleModalPais,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                                      color: const Color(0xffFAFAFA),
                                      border: Border.all(color: const Color(0xffC7C6C8), width: 0.7),
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.of(context).pop(true),
                                          child: const ButtonPrimary(
                                            title: "Eliminar",
                                            validator: false,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        InkWell(
                                          onTap: () => Navigator.of(context).pop(false),
                                          child: const ButtonPrimary(
                                            title: "Cancelar",
                                            validator: false,
                                            secondary: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );

        return deleteConfirmed;
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          ref.read(listProductProvider.notifier).deleteProduct(product.sku);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Producto del SKU: ${product.sku} eliminado'),
              duration: const Duration(milliseconds: 1000),
            ),
          );
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Eliminar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text("${index + 1}.- SKU ${product.sku} - ${product.modelo}"),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}

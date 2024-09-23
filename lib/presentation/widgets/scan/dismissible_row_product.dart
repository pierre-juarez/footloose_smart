import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
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
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Confirmación',
                style: robotoStyle(20, FontWeight.w600, Colors.black),
                textAlign: TextAlign.center,
              ),
              content: Text(
                '¿Estás seguro de que quieres eliminar un producto del SKU: ${product.sku}?',
                style: robotoStyle(15, FontWeight.normal, Colors.black),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(true),
                        child: const ButtonPrimary(
                          validator: false,
                          title: "Eliminar",
                          type: "small",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(false),
                        child: ButtonPrimary(
                          validator: false,
                          title: "Cancelar",
                          type: "small",
                          color: AppTheme.colorSecondary,
                        ),
                      ),
                    ),
                  ],
                )
              ],
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

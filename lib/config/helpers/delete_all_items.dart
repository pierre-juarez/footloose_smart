import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/show_modal.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';

Future<void> deleteAllItemsQueue(WidgetRef ref, BuildContext context, [VoidCallback? function]) async {
  showModal(
    context,
    () async {
      ref.read(listProductProvider.notifier).deleteAllProducts();
      Navigator.of(context).pop();
      if (function != null) function();
    },
    "Cancelar operación",
    "¿Desea realmente cancelar la operación, este proceso reiniciará la fila?",
  );
}

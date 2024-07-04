import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/show_modal.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/queue_active_provider.dart';

Future<void> deleteAllItemsQueue(WidgetRef ref, BuildContext context, VoidCallback function) async {
  showModal(
    context,
    () async {
      ref.read(listProductProvider.notifier).deleteAllProducts();
      ref.read(queueActiveProvider.notifier).disableQueue();
      Navigator.of(context).pop();
      function();
    },
    "Vacíar carrito",
    "¿Desea eliminar todos los ítems de la fila?",
  );
}

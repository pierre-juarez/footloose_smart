import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/custom_modal.dart';

Future<void> deleteAllItemsQueue(WidgetRef ref, BuildContext context, [VoidCallback? function]) async {
  await showCustomModal(
    context,
    "Cancelar Operación",
    "¿Está seguro de cancelar la operación?, \n este proceso reiniciará la cola.",
    "Continuar",
    () {
      ref.read(listProductProvider.notifier).deleteAllProducts();
      Navigator.of(context).pop();
      if (function != null) function();
    },
    paddingHorizontal: 40,
    cancelText: "Cancelar",
  );
}

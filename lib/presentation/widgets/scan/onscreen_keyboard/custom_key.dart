import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/presentation/providers/product/sku_search_provider.dart';

class CustomKey extends ConsumerWidget {
  final String label;

  const CustomKey({super.key, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skuSearchMethods = ref.watch(skuSearchProvider.notifier);

    return InkWell(
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(45), border: Border.all(color: Colors.black, width: 1)),
        child: Center(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 35))),
      ),
      onTap: () => skuSearchMethods.typeItem(label),
    );
  }
}

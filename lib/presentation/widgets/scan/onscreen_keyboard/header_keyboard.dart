import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/presentation/providers/product/sku_search_provider.dart';

class HeaderKeyboard extends ConsumerWidget {
  const HeaderKeyboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skuSearch = ref.watch(skuSearchProvider);

    String textHeader = (skuSearch.isEmpty) ? "Ingrese el código SKU o CU" : skuSearch;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        textHeader,
        style: robotoStyle(20, FontWeight.w400, Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}

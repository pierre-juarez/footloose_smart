import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:footloose_tickets/presentation/providers/product/sku_search_provider.dart';

class ButtonDeleteNumber extends ConsumerWidget {
  const ButtonDeleteNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skuSearchMethods = ref.watch(skuSearchProvider.notifier);

    return InkWell(
      onTap: () => skuSearchMethods.deleteItem(),
      child: SvgPicture.asset("lib/assets/delete_keyboard.svg"),
    );
  }
}

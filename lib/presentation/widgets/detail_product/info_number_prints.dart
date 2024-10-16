import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/detail_product/button_lateral_print.dart';

class CardInfoNumberPrints extends ConsumerStatefulWidget {
  const CardInfoNumberPrints({
    super.key,
    required this.producId,
  });

  final String producId;

  @override
  InfoNumberPrintsState createState() => InfoNumberPrintsState();
}

class InfoNumberPrintsState extends ConsumerState<CardInfoNumberPrints> {
  bool loadingPage = false;
  int count = 2;

  @override
  Widget build(BuildContext context) {
    Future<void> navigateToPreview() async {
      setState(() => loadingPage = true);

      await ref.read(listProductProvider.notifier).updateProduct(widget.producId, count);
      appRouter.go('/preview', extra: {'replace': true});

      setState(() => loadingPage = false);
    }

    void add() {
      setState(() => count++);
    }

    void subtract() {
      if (count == 1) {
        showError(context, title: "Error", errorMessage: "El número actual de impresiones no puede ser menor a 1");
        return;
      }
      setState(() => count--);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        boxShadow: AppStyles.shadowCard,
        color: AppColors.textLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Text("Número de etiquetas", style: AppTextStyles.displayTextBasicCardLigth),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonLateralPrint(function: subtract, title: "-"),
                  Text(
                    "$count",
                    style: AppTextStyles.displayTitle1Bold,
                  ),
                  ButtonLateralPrint(function: add, title: "+"),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () async => navigateToPreview(),
              child: ButtonPrimary(validator: loadingPage, title: "Previsualizar etiqueta"),
            ),
          ],
        ),
      ),
    );
  }
}

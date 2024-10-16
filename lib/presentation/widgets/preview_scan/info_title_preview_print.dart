import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/preview_scan/title_print_review.dart';

class InfoTitlePreviewPrint extends StatelessWidget {
  const InfoTitlePreviewPrint({
    super.key,
    required this.countItems,
    required this.countProducts,
  });

  final int countItems;
  final int countProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitlePrintReview(title: "N° de Etiquetas: ", subtitle: "$countItems"),
              TitlePrintReview(title: "N° de Productos: ", subtitle: "$countProducts"),
            ],
          ),
        ),
        // const SizedBox(height: 8),
        const Divider(
          thickness: 1,
          color: AppColors.textDark,
        )
      ],
    );
  }
}

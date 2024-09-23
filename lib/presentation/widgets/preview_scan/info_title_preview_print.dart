import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitlePrintReview(title: "N° etiquetas: ", subtitle: "$countItems"),
              TitlePrintReview(title: "N° Productos: ", subtitle: "$countProducts"),
            ],
          ),
          const Divider(thickness: 1.5)
        ],
      ),
    );
  }
}

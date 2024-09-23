import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/presentation/widgets/detail_product/button_lateral_print.dart';

class InfoNumberPrints extends StatelessWidget {
  const InfoNumberPrints({
    super.key,
    required this.count,
    required this.subtract,
    required this.add,
  });

  final int count;
  final VoidCallback subtract;
  final VoidCallback add;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text("Número de etiquetas", style: robotoStyle(16, FontWeight.w600, Colors.black)),
          const SizedBox(height: 5),
          Row(
            children: [
              ButtonLateralPrint(function: subtract, title: "-1"),
              const SizedBox(width: 25),
              Text(
                "$count",
                style: robotoStyle(18, FontWeight.w500, Colors.black),
              ),
              const SizedBox(width: 25),
              ButtonLateralPrint(function: add, title: "+1"),
            ],
          ),
        ],
      ),
    );
  }
}

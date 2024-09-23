import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';

class CardTemporada extends StatelessWidget {
  const CardTemporada({
    super.key,
    required this.temporada,
  });

  final String temporada;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffFFB547),
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Text(
        temporada,
        style: robotoStyle(15, FontWeight.w500, Colors.black),
      ),
    );
  }
}

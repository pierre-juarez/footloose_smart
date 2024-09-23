import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';

class TitlePrintReview extends StatelessWidget {
  const TitlePrintReview({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: title, style: robotoStyle(16, FontWeight.bold, Colors.black)),
          TextSpan(text: subtitle, style: robotoStyle(16, FontWeight.normal, Colors.black))
        ],
      ),
    );
  }
}

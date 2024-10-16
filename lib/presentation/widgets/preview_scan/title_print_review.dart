import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';

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
          TextSpan(text: title, style: AppTextStyles.displayTextBasicCardLigth),
          TextSpan(text: subtitle, style: AppTextStyles.displayTextBasicCardLigth)
        ],
      ),
    );
  }
}

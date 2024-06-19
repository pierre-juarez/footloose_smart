import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';

class InputTitle extends StatelessWidget {
  final String? title;
  const InputTitle({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title ?? "",
        textAlign: TextAlign.start,
        style: robotoStyle(15, FontWeight.w500, AppTheme.colorStyleText),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';

class ButtonBasic extends StatelessWidget {
  final bool state;
  final String title;

  final bool? loading;

  const ButtonBasic({
    super.key,
    required this.state,
    required this.title,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    Color colorButton;

    if (!state) {
      // Cambiar a !state
      colorButton = Colors.grey;
    } else {
      colorButton = (loading != null && loading!) ? Colors.grey : AppTheme.colorSecondary;
    }

    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorButton,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: (loading != null && loading!)
            ? const CircularProgressIndicator()
            : Text(
                title,
                style: robotoStyle(17, FontWeight.w600, AppTheme.colorStyleText),
              ),
      ),
    );
  }
}

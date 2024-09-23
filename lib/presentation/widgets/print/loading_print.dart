
import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';

class LoadingPrint extends StatelessWidget {
  const LoadingPrint({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppTheme.colorPrimary),
          const SizedBox(height: 13),
          Text(
            "Buscando impresoras...",
            style: robotoStyle(15, FontWeight.w400, Colors.black),
          )
        ],
      ),
    );
  }
}
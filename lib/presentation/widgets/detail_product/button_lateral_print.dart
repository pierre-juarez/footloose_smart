import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';

class ButtonLateralPrint extends StatelessWidget {
  const ButtonLateralPrint({
    super.key,
    required this.function,
    required this.title,
  });

  final VoidCallback function;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryMain, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(title, style: const TextStyle(fontSize: 35, color: AppColors.primaryMain)),
        ),
      ),
    );
  }
}

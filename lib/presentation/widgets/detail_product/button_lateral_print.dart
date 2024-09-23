import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

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
    return Expanded(
      child: InkWell(
        onTap: () => function(),
        child: ButtonPrimary(validator: false, title: title),
      ),
    );
  }
}

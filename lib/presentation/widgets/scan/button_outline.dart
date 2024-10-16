import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';

class ButtonOutline extends StatelessWidget {
  final String title;
  final Function() callback;
  const ButtonOutline({super.key, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    Color colorButton = const Color(0xff1E1D20).withOpacity(0.6);
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: colorButton, width: 1)),
        child: Text(
          title,
          style: AppTextStyles.displayTextButtonOutlineWhite,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

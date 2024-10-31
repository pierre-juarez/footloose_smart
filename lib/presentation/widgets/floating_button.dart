import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(100)),
      height: 64,
      width: 64,
      child: InkWell(
        onTap: () async => await onPressed(),
        child: Icon(icon, color: AppColors.primaryDarkButton),
      ),
    );
  }
}

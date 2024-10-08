import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';

class ButtonPrimary extends StatelessWidget {
  final bool validator;
  final String title;
  final String? type;
  final IconData? icon;
  final Color? color;
  final String? orientation;
  final bool? loading;

  const ButtonPrimary({
    super.key,
    required this.validator,
    required this.title,
    this.type,
    this.icon,
    this.color,
    this.orientation,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    Color colorButton;

    if (validator) {
      // Cambiar a !validator
      colorButton = Colors.grey;
    } else {
      colorButton = color != null ? color! : AppColors.primaryMain;
    }

    return Container(
      height: type != null ? 34 : 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorButton,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: (loading != null && loading!)
            ? const CircularProgressIndicator()
            : (validator)
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      icon != null && (orientation == null || orientation != "right")
                          ? Icon(
                              icon,
                              color: AppColors.textLight,
                              size: 25,
                            )
                          : Container(),
                      icon != null && (orientation == null || orientation != "right") ? const SizedBox(width: 15) : Container(),
                      Text(
                        title,
                        style: robotoStyle(type != null ? 16 : 17, FontWeight.w600, AppColors.textLight),
                      ),
                      icon != null && (orientation != null && orientation == "right") ? const SizedBox(width: 15) : Container(),
                      icon != null && (orientation != null && orientation == "right")
                          ? Icon(
                              icon,
                              color: AppColors.textLight,
                              size: 25,
                            )
                          : Container(),
                    ],
                  ),
      ),
    );
  }
}

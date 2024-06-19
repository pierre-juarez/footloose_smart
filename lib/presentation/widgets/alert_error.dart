import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

class AlertError extends StatelessWidget {
  final String? title;
  final String? errorMessage;
  final String? buttonText;
  final VoidCallback? onTap;
  final Widget? icon;

  const AlertError({
    super.key,
    this.title,
    this.errorMessage,
    this.buttonText,
    this.onTap,
    this.icon,
  });

  _handleTap(BuildContext context) {
    return onTap != null
        ? () {
            onTap!();
            Navigator.pop(context);
          }
        : () {
            Navigator.pop(context);
          };
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? icon!
                : const Icon(
                    FontAwesomeIcons.triangleExclamation,
                    color: Colors.red,
                    size: 30,
                  ),
            const SizedBox(height: 10),
            Text(
              title ?? "Advertencia",
              style: robotoStyle(16, FontWeight.w500, Colors.red),
            ),
            const SizedBox(height: 18),
            Text(
              errorMessage ?? "Ocurrió un error en el proceso",
              style: robotoStyle(15, FontWeight.w400, Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            InkWell(
              onTap: _handleTap(context),
              child: ButtonPrimary(
                validator: false,
                title: buttonText ?? "OK",
                type: "small",
              ),
            )
          ],
        ),
      ),
    );
  }
}

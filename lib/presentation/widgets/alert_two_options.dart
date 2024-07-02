import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

class AlertTwoOptions extends StatelessWidget {
  final String? title;
  final String? errorMessage;
  final String? buttonText;
  final String? buttonText2;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final Widget? icon;
  final String? type;

  const AlertTwoOptions({
    super.key,
    this.title,
    this.errorMessage,
    this.buttonText,
    this.buttonText2,
    this.onTap,
    this.onCancel,
    this.icon,
    this.type,
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

  _handleCancel(BuildContext context) {
    return onCancel != null
        ? () {
            onCancel!();
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
              style: robotoStyle(16, FontWeight.w500, (icon != null ? ((icon as Icon).color ?? Colors.red) : Colors.red)),
            ),
            const SizedBox(height: 18),
            Text(
              errorMessage ?? "Ocurrió un error en el proceso",
              style: robotoStyle(15, FontWeight.w400, Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _handleTap(context),
                    child: ButtonPrimary(
                      validator: false,
                      title: buttonText ?? "OK",
                      type: "small",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: _handleCancel(context),
                    child: ButtonPrimary(
                      validator: false,
                      title: buttonText2 ?? "OK",
                      type: "small",
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

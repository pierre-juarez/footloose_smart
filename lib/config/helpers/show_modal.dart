import 'dart:async';
import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

Future<void> showModal(BuildContext context, VoidCallback onTap, String title, String content) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: robotoStyle(20, FontWeight.w600, Colors.black),
      ),
      content: Text(
        content,
        style: robotoStyle(16, FontWeight.normal, Colors.black),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onTap,
                child: const ButtonPrimary(
                  validator: false,
                  title: "Si",
                  type: "small",
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: ButtonPrimary(
                  validator: false,
                  title: "Cancelar",
                  type: "small",
                  color: AppTheme.colorSecondary.withOpacity(0.8),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

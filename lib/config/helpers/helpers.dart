import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/presentation/widgets/alert_error.dart';

bool isNumeric(String str) {
  final RegExp regex = RegExp(r'^[0-9]+$');
  return regex.hasMatch(str);
}

Future<void> showError(
  BuildContext context, {
  String? title,
  String? errorMessage,
  String? buttonText,
  VoidCallback? onTap,
  Widget? icon,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertError(
      title: title,
      errorMessage: errorMessage,
      buttonText: buttonText,
      onTap: onTap,
      icon: icon,
    ),
  );
}

void navigateToPushReplacement(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

Future<void> redirectToPage(String routeName) async {
  await appRouter.pushReplacement(routeName);
}

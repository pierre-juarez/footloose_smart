import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/presentation/widgets/alert_error.dart';
import 'package:footloose_tickets/presentation/widgets/alert_two_options.dart';

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
  String? type,
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
      type: type,
    ),
  );
}

Future<void> showErrorTwo(
  BuildContext context, {
  String? title,
  String? errorMessage,
  String? buttonText,
  String? buttonText2,
  VoidCallback? onTap,
  VoidCallback? onCancel,
  Widget? icon,
  String? type,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertTwoOptions(
      title: title,
      errorMessage: errorMessage,
      buttonText: buttonText,
      buttonText2: buttonText2,
      onTap: onTap,
      onCancel: onCancel,
      icon: icon,
      type: type,
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

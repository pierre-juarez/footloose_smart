import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/get_errors.dart';
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

Future<void> redirectToPage(String routeName) async {
  await appRouter.pushReplacement(routeName);
}

String formatToTwoDecimalPlaces(double value) {
  return value.toStringAsFixed(2);
}

String formatDate(DateTime dateTime) {
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}

void handleError(BuildContext context, int statusCode) async {
  String errorCode;

  switch (statusCode) {
    case 408:
      errorCode = "E004";
      break;
    case 500:
      errorCode = "E009";
      break;
    default:
      errorCode = "E010";
      break;
  }

  final errorMessage = await getErrorJSON(errorCode);
  if (!context.mounted) return;
  showError(context, title: "Error", errorMessage: errorMessage);
}

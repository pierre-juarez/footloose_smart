import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/widgets/custom_modal.dart';

Future<void> showModalLogout(BuildContext context, AuthProvider auth) async {
  return await showCustomModal(
    context,
    "Cerrar Sesión",
    "¿Estás seguro que deseas cerrar sesión?",
    "Cerrar Sesión",
    () async {
      auth.clearInputs();
      await auth.logout();
      redirectToPage("/");
    },
    cancelText: "Cancelar",
  );
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/presentation/providers/configuration/client_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:crypto/crypto.dart';
import 'package:footloose_tickets/presentation/widgets/home/dialog_select_pais.dart';

class ButtonInitLogin extends ConsumerWidget {
  const ButtonInitLogin({
    super.key,
    required this.showModal,
  });

  final bool showModal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final config = ref.read(configurationProvider);
    final clients = ref.read(clientProvider);

    String encriptPassword(password) {
      return sha512.convert(utf8.encode(password)).toString().toUpperCase().substring(0, 100);
    }

    Future<void> login(AuthProvider auth) async {
      auth.outLoadingLogin = true;
      auth.androidId = "d8717c823081b284";
      final String encryptPass = encriptPassword(auth.password);
      await redirectToHome(context, auth, encryptPass, config, ref);
      auth.outLoadingLogin = false;
    }

    Future<void> handleTap(AuthProvider auth) async {
      if (auth.usuario.length < 6 || auth.password.isEmpty) {
        showError(context, title: "Error", errorMessage: "Ingresa un usuario o contraseña válidos");
        return;
      }

      if (!auth.outLoadingLogin) {
        await login(auth);
      }

      if (showModal) {
        await clients.getClients();
        print("🚀 ~ file: button_login.dart ~ line: 51 ~ TM_FUNCTION: ");
        if (!context.mounted) return;
        showModalSelectPais(context, ref, config);
        // TODO - Revisar temita de configuración
      }
    }

    return GestureDetector(
      onTap: () => handleTap(auth),
      child: ButtonPrimary(validator: auth.outLoadingLogin, title: "Iniciar Sesión"), //  auth.outLoadingLogin
    );
  }
}

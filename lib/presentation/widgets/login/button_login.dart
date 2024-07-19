import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/get_errors.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:crypto/crypto.dart';

class ButtonInitLogin extends ConsumerWidget {
  const ButtonInitLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final config = ref.read(configurationProvider);

    String encriptPassword(password) {
      return sha512.convert(utf8.encode(password)).toString().toUpperCase().substring(0, 100);
    }

    Future<void> login(AuthProvider auth) async {
      auth.outLoadingLogin = true;
      auth.androidId = "d8717c823081b284";

      final String encryptPass = encriptPassword(auth.password);

      await redirectToHome(context, auth, encryptPass, config);

      auth.outLoadingLogin = false;
    }

    Future<void> handleTap(AuthProvider auth) async {
      if (auth.usuario.length < 6 || auth.password.isEmpty) {
        showError(context, title: "Error", errorMessage: await getErrorJSON("E002"));
        return;
      }

      if (!auth.outLoadingLogin) {
        await login(auth);
      }
    }

    return GestureDetector(
      onTap: () => handleTap(auth),
      child: ButtonPrimary(validator: auth.outLoadingLogin, title: "Iniciar sesión"), //  auth.outLoadingLogin
    );
  }
}

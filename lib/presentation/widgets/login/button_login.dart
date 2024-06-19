import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/get_errors.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:crypto/crypto.dart';

class ButtonInitLogin extends ConsumerWidget {
  const ButtonInitLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    Future<void> redirectToHome() async {
      await showError(
        context,
        errorMessage: "Bienvenido al Sistema",
        buttonText: "OK",
        onTap: () async {
          await redirectToPage("/home");
        },
      );
    }

    void handleError(int statusCode) async {
      switch (statusCode) {
        case 408:
          showError(context, title: "Error", errorMessage: await getErrorJSON("E004"));
          break;
        case 500:
          showError(context, title: "Error", errorMessage: await getErrorJSON("E009"));
          break;
        default:
          showError(context, title: "Error", errorMessage: await getErrorJSON("E010"));
          break;
      }
    }

    String encriptPassword(password) {
      return sha512.convert(utf8.encode(password)).toString().toUpperCase().substring(0, 100);
    }

    Future<void> login(AuthProvider auth) async {
      auth.outLoadingLogin = true;
      auth.androidId = "d8717c823081b284";

      final String encryptPass = encriptPassword(auth.password);

      final loginStatus = await auth.login(
        auth.usuario,
        encryptPass,
        auth.androidId,
      );

      if (context.mounted) {
        FocusScope.of(context).unfocus(); //quitar el teclado cuando se ya  se ingreso el los datos
      }

      if (loginStatus) {
        auth.isConnect = true;
        redirectToHome();
      } else {
        auth.isConnect = false;
        if (context.mounted) {
          handleError(auth.statusCodeLogin);
        }
      }

      auth.outLoadingLogin = false;
    }

    Future<void> handleTap(AuthProvider auth) async {
      if (auth.usuario.length < 6 || auth.password.isEmpty) {
        if (context.mounted) {
          showError(context, title: "Error", errorMessage: await getErrorJSON("E002"));
        }
        return;
      }

      if (!auth.outLoadingLogin) {
        await login(auth);
      }
    }

    return GestureDetector(
      onTap: () => handleTap(auth),
      child: const ButtonPrimary(validator: false, title: "Iniciar sesión"), //  auth.outLoadingLogin
    );
  }
}

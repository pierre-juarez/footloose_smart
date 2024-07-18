import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/configuration/client_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/widgets/logo_widget.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';

class SplashScreen extends ConsumerWidget {
  static const name = 'splash-screen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: FutureBuilder(
          future: checkLogin(context, ref),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageLogoFootloose(),
                  TextWidgetInput(
                    text: "Validando configuración...",
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colorStyleText,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future checkLogin(BuildContext context, WidgetRef ref) async {
    final auth = ref.read(authProvider);
    final config = ref.read(configurationProvider);
    final clients = ref.read(clientProvider);

    final String configId = await config.getConfigId();
    // final bool logeado = await auth.isLoggedIn();
    final bool logeado = await isLoggedIn(context, auth);

    // STUB - Realiza un diagrama de flujo de la app
    final existClients = await config.existClients();
    print("🚀 ~ file: splash_screen.dart ~ line: 48 ~ TM_FUNCTION: $configId");
    // TODO O no hay ningún cliente en BD en ISAR
    if (!existClients || configId.isEmpty) {
      print("🚀 ~ file: splash_screen.dart ~ line: 53 ~ TM_FUNCTION: ");
      await clients.getClients();
      print("🚀 ~ file: splash_screen.dart ~ line: 55 ~ TM_FUNCTION: ");
      // TODO - Muestreo de icons según lo que tiene en la BD
      await redirectToPage("/configuration");
    } else {
      if (logeado) {
        await redirectToPage("/home");
      } else {
        auth.clearInputs();
        await redirectToPage("/login");
      }
    }
  }
}

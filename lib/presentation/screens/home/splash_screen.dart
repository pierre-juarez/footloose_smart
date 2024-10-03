import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/delete_config.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/configuration/client_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/pais/pais_provider.dart';
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
        },
      ),
    );
  }

  Future checkLogin(BuildContext context, WidgetRef ref) async {
    final config = ref.read(configurationProvider);
    final auth = ref.read(authProvider);
    final clients = ref.read(clientProvider);

    try {
      final String configId = await config.getConfigId();
      final bool existClients = await config.existClients();

      if (!existClients || configId.isEmpty) {
        // TODO - Muestreo de icons según lo que tiene en la BD
        await clients.getClients();
        await redirectToPage("/configuration");
      } else {
        if (!context.mounted) return;
        final bool logeado = await isLoggedIn(context, auth);

        if (logeado) {
          await redirectToPage("/home");
        } else {
          auth.clearInputs();
          await redirectToPage("/login");
        }
      }
    } catch (e) {
      ref.read(selectedOptionProvider.notifier).resetSelection();
      await deleteConfigAll(config);
      await SystemNavigator.pop();
      if (!context.mounted) return;
      await showError(
        context,
        title: "Error",
        errorMessage: "$e \n Inicie nuevamente el app. - ESS",
        buttonText: "Cerrar",
      );
      return;
    }
  }
}

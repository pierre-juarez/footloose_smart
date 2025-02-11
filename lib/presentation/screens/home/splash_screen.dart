import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/delete_config.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/pais/pais_provider.dart';
import 'package:footloose_tickets/presentation/providers/validate/validate_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/logo_widget.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';

class SplashScreen extends ConsumerWidget {
  static const name = 'splash-screen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.bodyGray,
      body: FutureBuilder(
        future: checkLogin(context, ref),
        builder: (context, snapshot) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageLogoFootloose(),
                SizedBox(height: 15),
                TextWidgetInput(
                  text: "Validando configuración...",
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryMain,
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

    Future.delayed(const Duration(milliseconds: 100), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });

    try {
      final String configId = await config.getConfigId();
      final bool existClients = await config.existClients();

      // TODO - Muestreo de icons según lo que tiene en la BD

      if (!context.mounted) return;
      final bool emptyClients = (!existClients && configId.isEmpty);

      if (emptyClients) {
        auth.clearInputs();
        await config.deleteTablesIsar();
        await config.getConfigs();
        ref.read(validateProvider.notifier).statusValidate(emptyClients);
        await redirectToPage("/login");
      } else {
        final bool logeado = await isLoggedIn(context, auth);

        if (!logeado) {
          auth.clearInputs();
          await redirectToPage("/login", extra: emptyClients);
        } else {
          await redirectToPage("/home");
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

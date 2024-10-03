import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/delete_config.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/pais/pais_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_basic.dart';
import 'package:footloose_tickets/presentation/widgets/configuration/option_pais.dart';

class ConfigurationScreen extends ConsumerWidget {
  const ConfigurationScreen({super.key});

  static const name = "configuration-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption = ref.watch(selectedOptionProvider);

    void handleContinue() async {
      final config = ref.read(configurationProvider);
      final auth = ref.read(authProvider);

      if (selectedOption.option.isEmpty || selectedOption.optionId.isEmpty) {
        showError(context, title: "Error", errorMessage: "Seleccione un país válido");
        return;
      }

      try {
        await config.saveConfiguration(selectedOption.option, selectedOption.optionId);

        infoLog("🚀 ~ file: configuration_screen.dart ~ selectedOption.option ~  ${selectedOption.option}");
        infoLog("🚀 ~ file: configuration_screen.dart ~ selectedOption.optionId ~  ${selectedOption.optionId}");

        await config.getConfigs(selectedOption.optionId);

        if (!context.mounted) return;
        final bool logeado = await isLoggedIn(context, auth);

        if (logeado) {
          await redirectToPage("/home");
        } else {
          auth.clearInputs();
          await redirectToPage("/login");
        }
      } catch (e) {
        ref.read(selectedOptionProvider.notifier).resetSelection();
        await deleteConfigAll(config);
        await SystemNavigator.pop();
        if (!context.mounted) return;
        await showError(
          context,
          title: "Error",
          errorMessage: "$e \n Inicie nuevamente el app. - ECS",
          buttonText: "Cerrar",
        );
        return;
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              const SizedBox(height: 80.0),
              ElasticIn(
                child: const Image(
                  image: AssetImage("lib/assets/logo_shopper.png"),
                  height: 100,
                ),
              ),
              const SizedBox(height: 100),
              Text(
                "Seleccione su país",
                style: robotoStyle(22, FontWeight.bold, AppTheme.colorStyleText),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => ref.read(selectedOptionProvider.notifier).selectOption("Perú", "1"),
                    child: OptionPais(stringAsset: "lib/assets/peru.png", select: selectedOption.option == "Perú"),
                  ),
                  GestureDetector(
                    onTap: () => ref.read(selectedOptionProvider.notifier).selectOption("Ecuador", "2"),
                    child: OptionPais(stringAsset: "lib/assets/ecuador.png", select: selectedOption.option == "Ecuador"),
                  ),
                ],
              ),
              Visibility(
                visible: selectedOption.option.isNotEmpty,
                child: FadeInRight(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "País seleccionado: ${selectedOption.option}",
                        style: robotoStyle(16, FontWeight.w600, AppTheme.colorStyleText),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80),
              InkWell(
                onTap: () async => handleContinue(),
                child: const ButtonBasic(state: true, title: "Continuar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

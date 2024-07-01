import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_basic.dart';
import 'package:footloose_tickets/presentation/widgets/configuration/option_pais.dart';

class ConfigurationScreen extends ConsumerWidget {
  ConfigurationScreen({super.key});

  static const name = "configuration-screen";
  String optionSelect = "";
  String optionIdSelect = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void selectOption(String option, String optionId) {
      optionSelect = option;
      optionIdSelect = optionId;
    }

    void handleContinue() async {
      final config = ref.watch(configurationProvider);

      if (optionSelect.isEmpty || optionIdSelect.isEmpty) {
        showError(context, title: "Error", errorMessage: "Seleccione un país válido");
        return;
      }

      config.saveConfiguration(optionSelect, optionIdSelect);
      print("🚀 ~ file: configuration_screen.dart ~ line: 20 ~ TM_FUNCTION: $optionSelect");
      print("🚀 ~ file: configuration_screen.dart ~ line: 21 ~ TM_FUNCTION: $optionIdSelect");

      await redirectToPage("/login");
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
                  InkWell(
                    onTap: () => selectOption("Peru", "2"),
                    child: const OptionPais(stringAsset: "lib/assets/peru.png"),
                  ),
                  InkWell(
                    onTap: () => selectOption("Ecuador", "1"),
                    child: const OptionPais(stringAsset: "lib/assets/ecuador.png"),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              InkWell(
                onTap: () async => handleContinue(),
                child: const ButtonBasic(state: true, title: "Continuar"),
              )
            ],
          )),
    ));
  }
}

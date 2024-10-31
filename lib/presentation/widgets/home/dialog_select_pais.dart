import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/infraestructure/models/selection_pais_model.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/pais/pais_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/home/option_pais_dialog.dart';

Future<dynamic> showModalSelectPais(
  BuildContext context,
  WidgetRef ref,
  ConfigurationProvider config, {
  void Function()? callback,
}) {
  bool loadingContinue = false;

  Future<void> continueSelection(BuildContext context, Function setState) async {
    SelectedPais currentOption = ref.read(selectedOptionProvider);

    if (currentOption.optionId.isEmpty) {
      print("🚀 ~ file: appbar_options.dart ~ line: 113 ~ TM_FUNCTION: ");
      ref.read(selectedOptionProvider.notifier).reasignateOption(config.idOption);
    }

    SelectedPais optionSelected = ref.watch(selectedOptionProvider);

    if (config.idOption != optionSelected.optionId) {
      try {
        setState(() => loadingContinue = true);

        await config.deleteTablesConfigurationsIsar();
        // Lógica cuando el país ha cambiado
        await config.getConfigById(optionSelected.optionId);
        config.saveConfiguration(optionSelected.option, optionSelected.optionId);

        print("🚀 ~ file: appbar_options.dart ~ line: 114 ~ TM_FUNCTION: Trayendo config de backend...");
      } catch (e) {
        errorLog(e.toString());
        showError(context, title: "Error", errorMessage: "Error en el servidor. Intente nuevamente.");
        // TODO - Si hay un error, se debe mantener la selección anterior
        return;
      } finally {
        setState(() => loadingContinue = false);
        callback?.call();
      }
    }

    if (!context.mounted) return;
    Navigator.pop(context);
  }

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                                color: const Color(0xffFAFAFA),
                                border: Border.all(color: AppColors.bodySecondaryButton, width: 0.6),
                              ),
                              child: Center(
                                child: Text(
                                  "Seleccionar País",
                                  style: AppTextStyles.displayTitleModalPais,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 30, left: 30, top: 16, bottom: 16),
                              child: Column(
                                children: [
                                  Text(
                                    "Por favor seleccione el país en el que se encuentra",
                                    style: AppTextStyles.displaySubtitleModalPais,
                                  ),
                                  const SizedBox(height: 24),
                                  OptionPaisDialog(
                                    pais: "Perú",
                                    ref: ref,
                                    onSelect: () => setState(() {}),
                                    config: config,
                                  ),
                                  const SizedBox(height: 30),
                                  OptionPaisDialog(
                                    pais: "Ecuador",
                                    ref: ref,
                                    onSelect: () => setState(() {}),
                                    config: config,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                                color: const Color(0xffFAFAFA),
                                border: Border.all(color: const Color(0xffC7C6C8), width: 0.7),
                              ),
                              child: InkWell(
                                onTap: () async => await continueSelection(context, setState),
                                child: ButtonPrimary(
                                  title: "Continuar",
                                  validator: loadingContinue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

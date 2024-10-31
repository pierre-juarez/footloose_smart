import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/infraestructure/models/selection_pais_model.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/pais/pais_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/home/option_pais.dart';

class OptionPaisDialog extends StatelessWidget {
  const OptionPaisDialog({
    super.key,
    required this.pais,
    required this.ref,
    required this.onSelect,
    required this.config,
  });

  final String pais;
  final WidgetRef ref;
  final VoidCallback onSelect;
  final ConfigurationProvider config;

  @override
  Widget build(BuildContext context) {
    SelectedPais optionSelected = ref.watch(selectedOptionProvider);

    bool stateCheck = false;
    if (optionSelected.option.isEmpty) {
      String paisStr = "";
      if (config.idOption == "1") {
        paisStr = "Perú";
      } else if (config.idOption == "2") {
        paisStr = "Ecuador";
      }

      stateCheck = paisStr == pais;
    } else {
      stateCheck = optionSelected.option == pais;
    }

    String assetName = (pais == "Perú") ? "lib/assets/peru.png" : "lib/assets/ecuador.png";
    String paisID = (pais == "Perú") ? "1" : "2";

    void selectPais() {
      ref.read(selectedOptionProvider.notifier).selectOption(pais, paisID);
      onSelect();
    }

    return GestureDetector(
      onTap: () => selectPais(),
      child: Container(
        decoration: BoxDecoration(
          color: stateCheck ? AppColors.primaryLight : AppColors.textLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: stateCheck ? AppColors.primaryMain : AppColors.borderOption, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  OptionPais(stringAsset: assetName),
                  const SizedBox(width: 12),
                  Text(
                    pais,
                    style: AppTextStyles.displaySubtitleModalPais,
                  ),
                ],
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.textLight,
                  border: !stateCheck
                      ? Border.all(
                          color: AppColors.textDark,
                          width: 1,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: stateCheck
                    ? const Icon(
                        Icons.check,
                        size: 20,
                        color: AppColors.primaryMain,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

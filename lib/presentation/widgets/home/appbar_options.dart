import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/config/helpers/reset_configuration.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/infraestructure/models/selection_pais_model.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/pais/pais_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/selected_device_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/home/dialog_select_pais.dart';
import 'package:footloose_tickets/presentation/widgets/home/option_pais.dart';

class AppBarOptions extends StatelessWidget {
  AppBarOptions({
    super.key,
    required this.config,
    required this.ref,
    required this.auth,
  });

  final ConfigurationProvider config;
  final WidgetRef ref;
  final AuthProvider auth;
  bool loadingContinue = false;

  Future<void> selectedOption(BuildContext context) async {
    print("🚀 ~ file: appbar_options.dart ~ line: 28 ~ TM_FUNCTION: ${config.idOption}");
    print("🚀 ~ file: appbar_options.dart ~ line: 29 ~ TM_FUNCTION: ${ref.read(selectedOptionProvider).optionId}");
    // await _showOpenDialogPais(context);
    if (!context.mounted) return;
    await showModalSelectPais(context, ref, config);
  }

  // Future<void> continueSelection(BuildContext context, Function setState) async {
  //   SelectedPais currentOption = ref.read(selectedOptionProvider);

  //   if (currentOption.optionId.isEmpty) {
  //     print("🚀 ~ file: appbar_options.dart ~ line: 113 ~ TM_FUNCTION: ");
  //     ref.read(selectedOptionProvider.notifier).reasignateOption(config.idOption);
  //   }

  //   SelectedPais optionSelected = ref.watch(selectedOptionProvider);

  //   if (config.idOption != optionSelected.optionId) {
  //     try {
  //       setState(() => loadingContinue = true);

  //       // Lógica cuando el país ha cambiado
  //       await config.getConfigs(optionSelected.optionId);
  //       config.saveConfiguration(optionSelected.option, optionSelected.optionId);

  //       print("🚀 ~ file: appbar_options.dart ~ line: 114 ~ TM_FUNCTION: Trayendo config de backend...");
  //     } catch (e) {
  //       errorLog(e.toString());
  //       showError(context, title: "Error", errorMessage: "Error en el servidor. Intente nuevamente.");
  //       return;
  //     } finally {
  //       setState(() => loadingContinue = false);
  //     }
  //   }

  //   if (!context.mounted) return;
  //   Navigator.pop(context);
  // }

  // Future<dynamic> _showOpenDialogPais(BuildContext context) {
  //   return showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return PopScope(
  //         canPop: false,
  //         child: StatefulBuilder(
  //           builder: (context, setState) {
  //             return AlertDialog(
  //               backgroundColor: Colors.transparent,
  //               insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
  //               contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
  //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       Container(
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(6),
  //                           color: Colors.white,
  //                         ),
  //                         child: Column(
  //                           children: [
  //                             Container(
  //                               width: double.infinity,
  //                               height: 45,
  //                               decoration: BoxDecoration(
  //                                 borderRadius:
  //                                     const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
  //                                 color: const Color(0xffFAFAFA),
  //                                 border: Border.all(color: AppColors.bodySecondaryButton, width: 0.6),
  //                               ),
  //                               child: Center(
  //                                 child: Text(
  //                                   "Seleccionar País",
  //                                   style: AppTextStyles.displayTitleModalPais,
  //                                 ),
  //                               ),
  //                             ),
  //                             Container(
  //                               padding: const EdgeInsets.only(right: 30, left: 30, top: 16, bottom: 16),
  //                               child: Column(
  //                                 children: [
  //                                   Text(
  //                                     "Por favor seleccione el país en el que se encuentra",
  //                                     style: AppTextStyles.displaySubtitleModalPais,
  //                                   ),
  //                                   const SizedBox(height: 24),
  //                                   OptionPaisDialog(
  //                                     pais: "Perú",
  //                                     ref: ref,
  //                                     onSelect: () => setState(() {}),
  //                                     config: config,
  //                                   ),
  //                                   const SizedBox(height: 30),
  //                                   OptionPaisDialog(
  //                                     pais: "Ecuador",
  //                                     ref: ref,
  //                                     onSelect: () => setState(() {}),
  //                                     config: config,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Container(
  //                               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                               decoration: BoxDecoration(
  //                                   borderRadius:
  //                                       const BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
  //                                   color: const Color(0xffFAFAFA),
  //                                   border: Border.all(color: const Color(0xffC7C6C8), width: 0.7)),
  //                               child: InkWell(
  //                                 onTap: () async => await continueSelection(context, setState),
  //                                 child: ButtonPrimary(
  //                                   title: "Continuar",
  //                                   validator: loadingContinue,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    String assetName = (config.idOption == "1") ? "lib/assets/peru.png" : "lib/assets/ecuador.png";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async => await selectedOption(context),
            child: OptionPais(stringAsset: assetName),
          ),
          const SizedBox(width: 24),
          InkWell(
            onTap: () async => await dialogLogOut(context, auth),
            child: const Icon(FontAwesomeIcons.arrowRightToBracket),
          )
        ],
      ),
    );
  }
}

// class OptionPaisDialog extends StatelessWidget {
//   const OptionPaisDialog({
//     super.key,
//     required this.pais,
//     required this.ref,
//     required this.onSelect,
//     required this.config,
//   });

//   final String pais;
//   final WidgetRef ref;
//   final VoidCallback onSelect;
//   final ConfigurationProvider config;

//   @override
//   Widget build(BuildContext context) {
//     // TODO - Revisar la reasignación de la opción seleccionada, si el optionselected esta vacío
//     // TODO - Revisar la page de configuración, si el optionSelected esta vacío

//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   SelectedPais optionSelected = ref.read(selectedOptionProvider);
//     //   if (optionSelected.optionId.isEmpty) {
//     //     print("🚀 ~ file: appbar_options.dart ~ line: 188 ~ TM_FUNCTION: ${config.idOption}");
//     //     ref.read(selectedOptionProvider.notifier).reasignateOption(config.idOption);
//     //   }else{

//     //   }
//     // });
//     SelectedPais optionSelected = ref.watch(selectedOptionProvider);

//     bool stateCheck = false;
//     if (optionSelected.option.isEmpty) {
//       String paisStr = config.idOption == "1" ? "Perú" : "Ecuador";
//       print("🚀 ~ file: appbar_options.dart ~ line: 186 ~ TM_FUNCTION: $paisStr");
//       stateCheck = paisStr == pais;
//     } else {
//       stateCheck = optionSelected.option == pais;
//     }
//     //stateCheck = optionSelected.option == pais;
//     print("🚀 ~ file: appbar_options.dart ~ line: 179 ~ TM_FUNCTION: ${optionSelected.option}");
//     print("🚀 ~ file: appbar_options.dart ~ line: 190 ~ TM_FUNCTION: $stateCheck");
//     String assetName = (pais == "Perú") ? "lib/assets/peru.png" : "lib/assets/ecuador.png";
//     String paisID = (pais == "Perú") ? "1" : "2";

//     void selectPais() {
//       ref.read(selectedOptionProvider.notifier).selectOption(pais, paisID);
//       onSelect();
//     }

//     return GestureDetector(
//       onTap: () => selectPais(),
//       child: Container(
//         decoration: BoxDecoration(
//           color: stateCheck ? AppColors.primaryLight : AppColors.textLight,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: stateCheck ? AppColors.primaryMain : AppColors.borderOption, width: 1),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   OptionPais(stringAsset: assetName),
//                   const SizedBox(width: 12),
//                   Text(
//                     pais,
//                     style: AppTextStyles.displaySubtitleModalPais,
//                   ),
//                 ],
//               ),
//               Container(
//                 width: 32,
//                 height: 32,
//                 decoration: BoxDecoration(
//                   color: AppColors.textLight,
//                   border: !stateCheck
//                       ? Border.all(
//                           color: AppColors.textDark,
//                           width: 1,
//                         )
//                       : null,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: stateCheck
//                     ? const Icon(
//                         Icons.check,
//                         size: 20,
//                         color: AppColors.primaryMain,
//                       )
//                     : null,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

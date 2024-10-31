import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/modal_logout.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/widgets/home/dialog_select_pais.dart';
import 'package:footloose_tickets/presentation/widgets/home/option_pais.dart';

// ignore: must_be_immutable
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
    if (!context.mounted) return;
    await showModalSelectPais(context, ref, config);
  }

  @override
  Widget build(BuildContext context) {
    String assetName = (config.idOption == "1") ? "lib/assets/peru.png" : "lib/assets/ecuador.png";
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async => await selectedOption(context),
            child: OptionPais(stringAsset: assetName),
          ),
          const SizedBox(width: 24),
          InkWell(
            onTap: () async => await showModalLogout(context, auth),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(FontAwesomeIcons.arrowRightToBracket),
              ),
            ),
          )
        ],
      ),
    );
  }
}

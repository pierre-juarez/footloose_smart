import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/reset_configuration.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';

class AppBarOptions extends StatelessWidget {
  const AppBarOptions({
    super.key,
    required this.config,
    required this.ref,
    required this.auth,
  });

  final ConfigurationProvider config;
  final WidgetRef ref;
  final AuthProvider auth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async => config.idOption.isNotEmpty ? await showModalDeleteConfiguration(context, ref) : null,
            child: Ink(
              child: Icon(
                FontAwesomeIcons.gears,
                color: config.idOption.isEmpty ? Colors.grey : Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 25),
          InkWell(
            onTap: () async => await showOptions(context, auth),
            child: const Icon(FontAwesomeIcons.arrowRightToBracket),
          )
        ],
      ),
    );
  }
}

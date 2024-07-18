import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/find_url_config.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/isar/config.schema.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';

Future<Configuration> getConfigOrThrow(String key) async {
  Configuration? config = await configurationWithKey(key);

  if (config == null) {
    throw ErrorDescription("No se pudo obtener valores para el API de $key.");
  }

  if (config.valor!.isEmpty) {
    throw ErrorDescription("No se pudo obtener el URL para el API de $key.");
  }

  if (config.typeRequest!.isEmpty) {
    throw ErrorDescription("No se pudo obtener el tipo de request para el API de $key.");
  }

  return config;
}

Future<void> redirectToScan(BuildContext context) async {
  try {
    final config = await getConfigOrThrow("PRODUCTO");

    final urlEncode = Uri.encodeComponent(config.valor!);
    final typeRequestEncode = Uri.encodeComponent(config.typeRequest!);
    await redirectToPage("/scan?urlScan=$urlEncode&typeRequest=$typeRequestEncode");
  } catch (e) {
    showError(context, title: "Error", errorMessage: "$e \n Cierra y abre el app.");
  }
}

Future<void> redirectToHome(BuildContext context, AuthProvider auth, String passwordEncrypted) async {
  try {
    final config = await getConfigOrThrow("LOGIN");

    final urlEncode = config.valor!;
    final typeRequestEncode = config.typeRequest!;

    final loginStatus = await auth.login(auth.usuario, passwordEncrypted, auth.androidId, urlEncode, typeRequestEncode);

    if (context.mounted) {
      FocusScope.of(context).unfocus(); //quitar el teclado cuando se ya  se ingreso el los datos
    }

    if (loginStatus) {
      await showError(
        context,
        errorMessage: "Bienvenido al Sistema",
        title: "¡Hola usuari@!",
        buttonText: "OK",
        type: "success",
        icon: Icon(
          FontAwesomeIcons.circleCheck,
          color: AppTheme.colorSecondary,
          size: 30,
        ),
        onTap: () async {
          await redirectToPage("/home");
        },
      );
    } else {
      handleError(context, auth.statusCodeLogin);
    }
  } catch (e) {
    showError(context, title: "Error", errorMessage: "$e \n Cierra y abre el app.");
  }
}

Future<bool> isLoggedIn(BuildContext context, AuthProvider auth) async {
  try {
    final config = await getConfigOrThrow("LOGGED");

    final urlEncode = config.valor!;
    final typeRequestEncode = config.typeRequest!;

    final bool logeado = await auth.isLoggedIn(urlEncode, typeRequestEncode);
    return logeado;
  } catch (e) {
    showError(context, title: "Error", errorMessage: "$e \n Cierra y abre el app.");
    return false;
  }
}

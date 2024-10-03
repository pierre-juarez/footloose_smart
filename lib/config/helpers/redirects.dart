import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/delete_config.dart';
import 'package:footloose_tickets/config/helpers/find_url_config.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/isar/config.schema.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/pais/pais_provider.dart';

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
  await Future.delayed(const Duration(milliseconds: 200));

  try {
    final config = await getConfigOrThrow("PRODUCTO");
    final urlEncode = Uri.encodeComponent(config.valor!);
    final typeRequestEncode = Uri.encodeComponent(config.typeRequest!);
    await appRouter.push('/scan?urlScan=$urlEncode&typeRequest=$typeRequestEncode');
  } catch (e) {
    if (!context.mounted) return;
    showError(context, title: "Error", errorMessage: "$e \n Cierra y abre el app.");
  }
}

Future<void> redirectToHome(
  BuildContext context,
  AuthProvider auth,
  String passwordEncrypted,
  ConfigurationProvider config,
  WidgetRef ref,
) async {
  try {
    final config = await getConfigOrThrow("LOGIN");
    final urlEncode = config.valor!;
    final typeRequestEncode = config.typeRequest!;
    final loginStatus = await auth.login(auth.usuario, passwordEncrypted, auth.androidId, urlEncode, typeRequestEncode);
    if (!context.mounted) return;
    FocusScope.of(context).unfocus(); //quitar el teclado cuando se ya  se ingreso el los datos

    if (loginStatus) {
      await welcomeSystem(context);
    } else {
      handleError(context, auth.statusCodeLogin);
    }
  } catch (e) {
    ref.read(selectedOptionProvider.notifier).resetSelection();
    await deleteConfigAll(config);
    await SystemNavigator.pop();
    if (!context.mounted) return;
    await showError(
      context,
      title: "Error",
      errorMessage: "$e \n Inicie nuevamente el app. - ERH",
      buttonText: "Cerrar",
    );
    return;
  }
}

Future<void> welcomeSystem(BuildContext context) async {
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
    onTap: () async => await redirectToPage("/home"),
  );
}

Future<bool> isLoggedIn(BuildContext context, AuthProvider auth) async {
  try {
    final config = await getConfigOrThrow("LOGGED");
    final urlEncode = config.valor!;
    final typeRequestEncode = config.typeRequest!;

    final bool logeado = await auth.isLoggedIn(urlEncode, typeRequestEncode);
    return logeado;
  } catch (e) {
    throw ErrorDescription("Error en isLoggedIn - $e");
  }
}

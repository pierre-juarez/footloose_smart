import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

Future<void> deleteConfiguration(BuildContext context, WidgetRef ref) async {
  final config = ref.watch(configurationProvider);

  await config.deleteConfig();
  await config.deleteTablesIsar();

  if (!context.mounted) return;

  showError(
    context,
    title: "Cónfiguración reseteada",
    errorMessage: "Tu configuración ha sido reseteada. Cierra y abre la aplicación para aplicar los cambios.",
    icon: Icon(
      FontAwesomeIcons.gears,
      color: AppTheme.colorSecondary,
      size: 30,
    ),
  );
}

Future<void> resetConfiguration(BuildContext context, WidgetRef ref) async {
  context.pop();
  await deleteConfiguration(context, ref);
}

Future<void> showModalDeleteConfiguration(BuildContext context, WidgetRef ref) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Borrar configuración',
        style: robotoStyle(20, FontWeight.w600, Colors.black),
      ),
      content: Text(
        '¿Está seguro que desea eliminar su configuración de país?',
        style: robotoStyle(16, FontWeight.normal, Colors.black),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async => resetConfiguration(context, ref),
                child: const ButtonPrimary(
                  validator: false,
                  title: "Eliminar",
                  type: "small",
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () => context.pop(),
                child: ButtonPrimary(
                  validator: false,
                  title: "Cancelar",
                  type: "small",
                  color: AppTheme.colorSecondary,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

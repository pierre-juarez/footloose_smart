import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

List<Widget>? buttonsFooter(BuildContext context, WidgetRef ref, List<EtiquetaModel> list) {
  return list.isNotEmpty
      ? [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async => await appRouter.pushReplacement('/preview'),
                  child: const ButtonPrimary(
                    validator: false,
                    title: "Revisar fila",
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () async => await deleteAllItemsQueue(ref, context),
                  child: ButtonPrimary(
                    validator: false,
                    title: "Vaciar fila",
                    color: AppTheme.colorSecondary,
                  ),
                ),
              ),
            ],
          ),
        ]
      : null;
}

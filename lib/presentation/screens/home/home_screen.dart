import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);
    final config = ref.watch(configurationProvider);
    final list = ref.watch(listProductProvider)['products'] ?? [];

    Future<void> viewPrint() async {
      final listsJson = jsonEncode(list.map((product) => product.toJson()).toList());
      await appRouter.pushReplacement('/review-queue?etiquetas=$listsJson');
    }

    Future<void> deleteAllItems() async {
      deleteAllItemsQueue(ref, context, () {});
    }

    Future<void> deleteConfiguration(BuildContext context) async {
      await config.deleteConfig();
      await config.deleteTablesIsar();

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

    Future<void> showModalDeleteConfiguration(BuildContext context) async {
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
                    onTap: () async {
                      context.pop();
                      await deleteConfiguration(context);
                    },
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
                    onTap: () {
                      context.pop();
                    },
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

    List<Widget>? buttonsFooter = list.isNotEmpty
        ? [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async => viewPrint(),
                    child: const ButtonPrimary(
                      validator: false,
                      title: "Revisar fila",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () async => deleteAllItems(),
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        persistentFooterButtons: buttonsFooter,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppTheme.backgroundColor,
          title: Text(
            "Impresión de etiquetas",
            style: robotoStyle(19, FontWeight.w400, Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async => config.idOption.isNotEmpty ? await showModalDeleteConfiguration(context) : null,
                    child: Ink(
                        child: Icon(
                      FontAwesomeIcons.gears,
                      color: config.idOption.isEmpty ? Colors.grey : Colors.white,
                    )),
                  ),
                  const SizedBox(width: 25),
                  InkWell(
                    onTap: () async => await showOptions(context, auth),
                    child: const Icon(FontAwesomeIcons.arrowRightToBracket),
                  )
                ],
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ConsultPage(listProducts: list),
          ],
        ),
      ),
    );
  }
}

class _ConsultPage extends StatefulWidget {
  const _ConsultPage({
    required this.listProducts,
  });

  final List<EtiquetaModel> listProducts;

  @override
  State<_ConsultPage> createState() => _ConsultPageState();
}

class _ConsultPageState extends State<_ConsultPage> {
  bool loadingScan = false;

  Future<void> navigateToScan() async {
    try {
      setState(() {
        loadingScan = true;
      });
      await Future.delayed(const Duration(milliseconds: 500));

      await redirectToScan(context);

      setState(() {
        loadingScan = false;
      });
    } catch (e) {
      print("Error al ir a la página de Escanner: $e");
      showError(context, title: "Error", errorMessage: "Error al navegar hacía la página de escaner. Cierra y abre el app.");
      setState(() {
        loadingScan = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<EtiquetaModel> listProducts = widget.listProducts;
    int countItems = listProducts.length;

    Set<String> skusUnicos = listProducts.map((etiqueta) => etiqueta.sku).toSet();
    int countProducts = skusUnicos.length;

    return Container(
      padding: const EdgeInsets.only(right: 50, left: 50, top: 200),
      child: Column(
        children: [
          Text(
            "Consultar Producto",
            style: robotoStyle(28, FontWeight.w500, AppTheme.backgroundColor),
          ),
          const SizedBox(height: 19),
          Text(
            "Pulsa 'Escanear' para empezar a escanear el código de barras del producto.",
            style: robotoStyle(14, FontWeight.w400, const Color(0xff7C7979).withOpacity(0.8)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Visibility(
            visible: widget.listProducts.isNotEmpty,
            child: Column(
              children: [
                Text(
                  "ítems en la fila: $countItems",
                  style: robotoStyle(15, FontWeight.w600, Colors.black),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Productos en la fila: $countProducts",
                  style: robotoStyle(15, FontWeight.w600, Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          InkWell(
            onTap: () async => navigateToScan(),
            child: ButtonPrimary(
              validator: loadingScan,
              title: "Escanear producto",
              icon: FontAwesomeIcons.qrcode,
            ),
          )
        ],
      ),
    );
  }
}

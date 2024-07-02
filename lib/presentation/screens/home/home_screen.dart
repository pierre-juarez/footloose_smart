import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/delete_all_items.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_basic.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: _PageHome(),
    );
  }
}

class _PageHome extends ConsumerWidget {
  const _PageHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final list = ref.watch(listProductProvider)['products'] ?? [];

    Future<void> viewPrint() async {
      final listsJson = jsonEncode(list.map((product) => product.toJson()).toList());
      await appRouter.pushReplacement('/review-queue?etiquetas=$listsJson');
    }

    Future<void> deleteAllItems() async {
      deleteAllItemsQueue(ref, context, () {});
    }

    List<Widget>? buttonsFooter = list.isNotEmpty
        ? [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async => deleteAllItems(),
                    child: const ButtonBasic(state: true, title: "Vacíar fila"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () async => viewPrint(),
                    child: const ButtonBasic(state: true, title: "Revisar fila"),
                  ),
                ),
              ],
            ),
          ]
        : null;

    return Scaffold(
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
            child: InkWell(
                onTap: () {
                  showOptions(context, auth);
                },
                child: const Icon(FontAwesomeIcons.arrowRightToBracket)),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _ConsultPage(
              listProducts: list,
            ),
          ),
        ],
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
    setState(() {
      loadingScan = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      await redirectToPage("/scan");
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 220),
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
          const SizedBox(height: 40),
          Visibility(
            visible: widget.listProducts.isNotEmpty,
            child: Text(
              "ítems en la fila: ${widget.listProducts.length}",
              style: robotoStyle(15, FontWeight.w600, Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 45),
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

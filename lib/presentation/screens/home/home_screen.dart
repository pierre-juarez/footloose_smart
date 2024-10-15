import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/logger.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/configuration_provider.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/home/appbar_options.dart';
import 'package:footloose_tickets/presentation/widgets/home/buttons_footer.dart';
import 'package:footloose_tickets/presentation/widgets/home/info_queue.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  bool loadingScan = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);
    final config = ref.watch(configurationProvider);
    final List<EtiquetaModel> list = ref.watch(listProductProvider)['products'] ?? [];

    int countItems = list.length;
    Set<String> skusUnicos = list.map((etiqueta) => etiqueta.sku).toSet();
    int countProducts = skusUnicos.length;

    Future<void> navigateToScan() async {
      try {
        setState(() => loadingScan = true);
        await redirectToScan(context);
      } catch (e) {
        errorLog("Error al ir a la página de Escanner: $e");
        if (!context.mounted) return;
        showError(context, title: "Error", errorMessage: "Error al navegar hacía la página de escaner. Cierra y abre el app.");
      } finally {
        setState(() => loadingScan = false);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bodyGray,
        persistentFooterButtons: buttonsFooter(context, ref, list),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.textLight),
          backgroundColor: AppColors.primaryDarken,
          title: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              "Impresión de Etiquetas",
              style: AppTextStyles.displayTitleAppBar,
            ),
          ),
          actions: [AppBarOptions(config: config, ref: ref, auth: auth)],
          toolbarHeight: 64,
          titleSpacing: 24,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 50, left: 50, top: 200),
              child: Column(
                children: [
                  Text(
                    "Consultar Producto",
                    style: AppTextStyles.displayTitle2Bold,
                  ),
                  const SizedBox(height: 19),
                  Text(
                    "Pulsa 'Escanear' para empezar a escanear el código de barras del producto.",
                    style: AppTextStyles.displaySubtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  InfoQueue(listProducts: list, countItems: countItems, countProducts: countProducts),
                  const SizedBox(height: 75),
                  InkWell(
                    onTap: () async => navigateToScan(),
                    child: ButtonPrimary(
                      validator: loadingScan,
                      title: "Escanear Producto",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

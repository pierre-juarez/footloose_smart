import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/redirects.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/floating_button.dart';
import 'package:footloose_tickets/presentation/widgets/preview_scan/buttons_footer_preview.dart';
import 'package:footloose_tickets/presentation/widgets/preview_scan/info_title_preview_print.dart';
import 'package:footloose_tickets/presentation/widgets/preview_scan/list_products_preview.dart';

class PreviewPrintScreen extends ConsumerStatefulWidget {
  static const name = "preview-print-screen";

  const PreviewPrintScreen({super.key});

  @override
  PreviewPrintScreenState createState() => PreviewPrintScreenState();
}

class PreviewPrintScreenState extends ConsumerState<PreviewPrintScreen> {
  List<GlobalKey> _globalKeys = [];
  bool loadingPrint = false;
  bool addingQueue = false;
  bool validCancelProcess = false;
  int count = 0;
  List<String> svgs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeData();
    });
  }

  void initializeData() {
    List<EtiquetaModel> listProducts = ref.read(listProductProvider)['products'] ?? [];
    createGlobalsKeys(listProducts);
    svgs = createSvgList(listProducts);
  }

  void createGlobalsKeys(List<EtiquetaModel> listProducts) {
    setState(() => _globalKeys = List.generate(listProducts.length, (index) => GlobalKey()));
  }

  List<String> createSvgList(List<EtiquetaModel> listProducts) {
    final barcode = Barcode.code128();
    List<String> listSvg = [];

    for (var i = 0; i < listProducts.length; i++) {
      final svg = barcode.toSvg(listProducts[i].sku, width: 400, height: 150);
      listSvg.add(svg);
    }
    return listSvg;
  }

  @override
  Widget build(BuildContext context) {
    final List<EtiquetaModel> listProducts = ref.watch(listProductProvider)['products'] ?? [];
    final ScrollController scrollController = ScrollController();

    int countItems = listProducts.fold(0, (previousValue, element) => previousValue + (element.numberOfPrints));
    Set<String> skusUnicos = listProducts.map((etiqueta) => etiqueta.sku).toSet();
    int countProducts = skusUnicos.length;

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarCustom(title: "Previsualización de Etiqueta"),
        backgroundColor: AppColors.bodyGray,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    height: (400 * countProducts) + 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.textLight,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: AppStyles.shadowCard,
                      ),
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      margin: const EdgeInsets.only(left: 26, right: 26, top: 32, bottom: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: InfoTitlePreviewPrint(countItems: countItems, countProducts: countProducts),
                          ),
                          const SizedBox(height: 10),
                          ListProductsPreview(
                            listProducts: listProducts,
                            globalKeys: _globalKeys,
                            svgs: svgs,
                            scrollController: scrollController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 26,
                    child: FloatingButton(
                      onPressed: () async => await redirectToScan(context),
                      icon: FontAwesomeIcons.plus,
                    ),
                  )
                ],
              ),
            ),
            ButtonsFooterPreview(globalKeys: _globalKeys, scrollController: scrollController)
          ],
        ),
      ),
    );
  }
}

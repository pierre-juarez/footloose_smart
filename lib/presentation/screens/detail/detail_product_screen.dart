import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/providers/product/list_product_provider.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/detail_product/card_producto.dart';
import 'package:footloose_tickets/presentation/widgets/detail_product/info_number_prints.dart';

class DetailProductPage extends ConsumerStatefulWidget {
  static const name = "product-screen";

  final EtiquetaModel etiqueta;

  const DetailProductPage({
    super.key,
    required this.etiqueta,
  });

  @override
  DetailProductPageState createState() => DetailProductPageState();
}

class DetailProductPageState extends ConsumerState<DetailProductPage> {
  bool loadingPage = false;
  int count = 2;

  @override
  Widget build(BuildContext context) {
    Future<void> navigateToPreview() async {
      setState(() => loadingPage = true);

      await ref.read(listProductProvider.notifier).updateProduct(widget.etiqueta.id, count);
      appRouter.go('/preview', extra: {'replace': true});

      setState(() => loadingPage = false);
    }

    void add() {
      setState(() => count++);
    }

    void subtract() {
      if (count == 1) {
        showError(context, title: "Error", errorMessage: "El número actual de impresiones no puede ser menor a 1");
        return;
      }
      setState(() => count--);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarCustom(title: "Detalle de producto"),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 21.0),
                    CardProduct(etiqueta: widget.etiqueta),
                    InfoNumberPrints(count: count, subtract: () => subtract(), add: () => add()),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () async => navigateToPreview(),
                        child: ButtonPrimary(validator: loadingPage, title: "Previsualizar etiqueta"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

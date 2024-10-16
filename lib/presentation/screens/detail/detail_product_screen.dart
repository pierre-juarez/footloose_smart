import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/theme/theme.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bodyGray,
        appBar: const AppBarCustom(title: "Detalle de producto"),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                color: AppColors.bodyGray,
                child: Column(
                  children: [
                    const SizedBox(height: 21.0),
                    CardProduct(etiqueta: widget.etiqueta),
                    const SizedBox(height: 24),
                    CardInfoNumberPrints(producId: widget.etiqueta.id)
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

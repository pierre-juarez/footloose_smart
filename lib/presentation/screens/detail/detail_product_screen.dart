import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/presentation/providers/product/queue_active_provider.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

class DetailProductPage extends ConsumerStatefulWidget {
  static const name = "product-screen";

  final ProductDetailModel product;

  const DetailProductPage({
    super.key,
    required this.product,
  });

  @override
  DetailProductPageState createState() => DetailProductPageState();
}

class DetailProductPageState extends ConsumerState<DetailProductPage> {
  bool loadingPage = false;
  int count = 2;

  @override
  Widget build(BuildContext context) {
    final activeQueue = ref.watch(queueActiveProvider)['activeQueue'];
    print("🚀 ~ file: detail_product_screen.dart ~ line: 36 ~ activeQueue: $activeQueue");

    final String temporada = widget.product.data?[0].temporada ?? "-";
    final String tipoArticulo = widget.product.data?[0].tipoDeArticulo ?? "-";
    final String material =
        "${widget.product.data?[0].material1}  ${widget.product.data?[0].material2}  ${widget.product.data?[0].material3}";
    final String nombre = widget.product.data?[0].nombre ?? "-";
    final String sku = widget.product.data?[0].producto ?? "-";
    final double pvp = widget.product.data?[0].preciobancoCiva ?? 0.0;
    final String talla = widget.product.data?[0].tallas ?? "-";
    final String fechaCreacion = formatDate(widget.product.data?[0].fechacompra ?? DateTime.now());
    final String marca = widget.product.data?[0].marca ?? "-";
    final String modelo = widget.product.data?[0].modelo ?? "-";
    final String imgUrl = widget.product.data?[0].urlimagen ?? "";

    List<String> splitNombre = nombre.split(" ");

    final String abrev = (splitNombre.isNotEmpty) ? splitNombre[4] : "-";
    final String color = "${widget.product.data?[0].color1}"; // REVIEW

    Future<void> navigateToPreview() async {
      setState(() {
        loadingPage = true;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      List<EtiquetaModel> listProducts = [];

      EtiquetaModel etiqueta = EtiquetaModel(
        marcaAbrev: "$marca - $abrev",
        tipoArticulo: tipoArticulo,
        modelo: modelo,
        color: color,
        material: material,
        precio: "\$/. $pvp",
        talla: talla,
        sku: sku,
        cu: "cu",
        fechaCreacion: fechaCreacion,
        temporada: temporada,
      );

      for (var i = 0; i < count; i++) {
        listProducts.add(etiqueta);
      }

      final listsJson = jsonEncode(listProducts.map((product) => product.toJson()).toList());
      await appRouter.pushReplacement('/preview?etiquetas=$listsJson&param=$activeQueue');

      setState(() {
        loadingPage = false;
      });
    }

    void add() {
      setState(() {
        count++;
      });
    }

    void subtract() {
      setState(() {
        if (count == 1) {
          showError(context, title: "Error", errorMessage: "El número actual de impresiones no puede ser menor a 1");
          return;
        }
        count--;
      });
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
                      CardProduct(
                        temporada: temporada,
                        tipoArticulo: tipoArticulo,
                        color: color,
                        material: material,
                        name: nombre,
                        marca: marca,
                        abrev: abrev,
                        modelo: modelo,
                        sku: sku,
                        cu: "cu",
                        talla: talla,
                        fechaCreacion: fechaCreacion,
                        precio: pvp,
                        img: imgUrl,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            Text("Número de impresiones", style: robotoStyle(16, FontWeight.w600, Colors.black)),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                        onTap: () => subtract(), child: const ButtonPrimary(validator: false, title: "-1"))),
                                const SizedBox(width: 25),
                                Text(
                                  "$count",
                                  style: robotoStyle(18, FontWeight.w500, Colors.black),
                                ),
                                const SizedBox(width: 25),
                                Expanded(
                                    child:
                                        InkWell(onTap: () => add(), child: const ButtonPrimary(validator: false, title: "+1"))),
                              ],
                            ),
                          ],
                        ),
                      ),
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
          )),
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppTheme.colorPrimary,
      onPressed: () async {
        await appRouter.pushReplacement("/home");
      },
      child: const Icon(
        FontAwesomeIcons.barcode,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}

class CardProduct extends StatelessWidget {
  final String temporada;
  final String tipoArticulo;
  final String material;
  final String color;
  final String name;
  final String marca;
  final String abrev;
  final String modelo;
  final String sku;
  final String cu;
  final double precio;
  final String talla;
  final String fechaCreacion;
  final String img;

  const CardProduct({
    super.key,
    required this.temporada,
    required this.tipoArticulo,
    required this.material,
    required this.color,
    required this.name,
    required this.marca,
    required this.abrev,
    required this.modelo,
    required this.sku,
    required this.cu,
    required this.precio,
    required this.talla,
    required this.fechaCreacion,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTemporada(temporada: temporada),
              const SizedBox(height: 10),
              Text(
                "$tipoArticulo / $material - $color",
                style: robotoStyle(13, FontWeight.w400, Colors.black),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: SizedBox(
                  height: 150.0,
                  child: (img.isNotEmpty) ? _ImageFound(path: img) : const _ImageNotFound(),
                ),
              ),
              const SizedBox(height: 15.0),
              Text(name),
              const SizedBox(height: 10),
              Text(marca),
              Text("$abrev - $modelo"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SKU: $sku - CU: $cu",
                        style: robotoStyle(15, FontWeight.w400, const Color(0xff666666)),
                      ),
                      Text(
                        "\$/. ${formatToTwoDecimalPlaces(precio)}",
                        style: robotoStyle(22, FontWeight.bold, AppTheme.colorPrimary),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      "Talla: $talla",
                      style: robotoStyle(15, FontWeight.w500, Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Text(
                "Fecha Creación: $fechaCreacion",
                style: robotoStyle(15, FontWeight.w400, Colors.black),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ],
    );
  }
}

class CardTemporada extends StatelessWidget {
  const CardTemporada({
    super.key,
    required this.temporada,
  });

  final String temporada;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffFFB547),
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Text(
        temporada,
        style: robotoStyle(15, FontWeight.w500, Colors.black),
      ),
    );
  }
}

class _ImageFound extends StatelessWidget {
  final String path;

  const _ImageFound({
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Image(image: NetworkImage(path));
  }
}

class _ImageNotFound extends StatelessWidget {
  const _ImageNotFound();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(213, 81, 91, 235),
        border: Border.all(
          color: AppTheme.colorPrimary,
          width: 2.0,
        ),
      ),
      child: const Center(
        child: Text(
          'Imagen no disponible',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

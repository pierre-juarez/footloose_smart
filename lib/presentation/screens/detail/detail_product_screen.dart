import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/router/app_router.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/infraestructure/models/product_model.dart';
import 'package:footloose_tickets/presentation/widgets/appbar_custom.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:go_router/go_router.dart';

class DetailProductPage extends StatefulWidget {
  static const name = "product-screen";
  final ProductModel productModel;

  const DetailProductPage({
    super.key,
    required this.productModel,
  });

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool loadingPage = false;
  @override
  Widget build(BuildContext context) {
    final String temporada = widget.productModel.data?[0].caracteristica.temporada.nombre ?? "-";
    const String tipoArticulo = "--tipoArticulo" ?? "--tipoArticulo";
    final String material =
        "${widget.productModel.data?[0].caracteristica.material.material1.nombre} ${widget.productModel.data?[0].caracteristica.material.material2.nombre} ${widget.productModel.data?[0].caracteristica.material.material3.nombre}";
    final String nombre = widget.productModel.data?[0].nombre ?? "-";

    final String sku = widget.productModel.data?[0].sku ?? "#modelo";
    const String cu = "--cu" ?? "--cu";
    final double pvp = widget.productModel.data?[0].precioBlanco ?? 0.0;
    final String talla = widget.productModel.data?[0].caracteristica.tallas.tallas.nombre ?? "--talla";
    const String fechaCreacion = "--fechaCreacion" ?? "--fechaCreacion";

    List<String> splitNombre = nombre.split(" ");

    final String marca = (splitNombre.isNotEmpty) ? splitNombre[0] : "-";
    final String modelo = (splitNombre.isNotEmpty) ? splitNombre[1] : "-";
    final String abrev = (splitNombre.isNotEmpty) ? splitNombre[4] : "-";
    final String color = (splitNombre.isNotEmpty) ? splitNombre[7].split("-")[0] : "-";

    Future<void> navigateToPreview() async {
      setState(() {
        loadingPage = true;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      EtiquetaModel etiqueta = EtiquetaModel(
        marcaAbrev: "$marca - $abrev",
        tipoArticulo: tipoArticulo,
        modelo: modelo,
        color: color,
        material: material,
        precio: "\$/. $pvp",
        talla: talla,
        sku: sku,
        cu: cu,
        fechaCreacion: fechaCreacion,
        temporada: temporada,
      );
      final etiquetaJson = jsonEncode(etiqueta.toJson());
      await context.push('/preview?etiqueta=$etiquetaJson');
      setState(() {
        loadingPage = false;
      });
    }

    return SafeArea(
      child: Scaffold(
          floatingActionButton: const FloatingButton(),
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
                        cu: cu,
                        talla: talla,
                        fechaCreacion: fechaCreacion,
                        precio: pvp,
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: InkWell(
                          onTap: () async => navigateToPreview(),
                          child: ButtonPrimary(validator: loadingPage, title: "Previsualizar etiqueta"),
                        ),
                      )
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
      backgroundColor: AppTheme.colorSecondary,
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
              const Center(
                child: SizedBox(
                  height: 150.0,
                  child:
                      // (imageProduct.isNotEmpty) ? _ImageFound(path: imageProduct) :
                      _ImageNotFound(),
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
                        "\$/. $precio",
                        style: robotoStyle(22, FontWeight.bold, AppTheme.colorSecondary),
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
          color: AppTheme.colorSecondary,
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

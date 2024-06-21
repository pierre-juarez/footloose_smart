import 'package:flutter/material.dart';
// import 'package:footloose_puntodeventa/src/data/api/auth_service.dart';
// import 'package:footloose_puntodeventa/src/data/api/consultForPartsSkuShoe_service.dart';
// import 'package:footloose_puntodeventa/src/data/provider/credenciales_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/info_scanner_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/search_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/values_consult_detail_provider.dart';
// import 'package:footloose_puntodeventa/src/domian/models/colorModel/color_list_tiendas_model.dart';
// import 'package:footloose_puntodeventa/src/domian/models/colorModel/data_color_model.dart';
// import 'package:footloose_puntodeventa/src/domian/models/forPartsShoe_model.dart';
// import 'package:footloose_puntodeventa/src/helpers/helpers.dart';
// import 'package:footloose_puntodeventa/src/ui/common/style.dart';
// import 'package:footloose_puntodeventa/src/ui/common/textStyle.dart';
// import 'package:footloose_puntodeventa/src/ui/detail/widgets/cateSubCateContainer_widget.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';

class InfoProduct extends StatefulWidget {
  final String temporada;
  // final String pathImage;
  // final String codMarca;
  // final String description;
  // final double price;
  // final double offerPrice;
  // final int stock;
  // final String sku;
  // final String categoria;
  // final String subcategoria;
  // final String talla;
  // //para el carrito
  // final DataDetail dataDetail;
  // final List<CusOfShoe> listCusOfShoe;
  // //textEditingController

  const InfoProduct({
    super.key,
    required this.temporada,
  });

  /**LINK - 
   * 
   *  required this.pathImage,
    required this.codMarca,
    required this.description,
    required this.price,
    required this.offerPrice,
    required this.stock,
    required this.sku,
    required this.dataDetail,
    required this.listCusOfShoe,
    required this.categoria,
    required this.subcategoria,
    required this.talla,
    super.key,
   */

  @override
  State<InfoProduct> createState() => _InfoProductState();
}

class _InfoProductState extends State<InfoProduct> {
  // final bool _isLoadingUpdateInfo = false;
  // bool _isLoadingGetInfoColorSku = false;
  // int _index = -1;
  // late List<ColorModel> listOfColorModelId = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final credenciales = Provider.of<CredencialesProvider>(context);
    // final consultSkuForParts = Provider.of<ConsultForPartsSkuShoeService>(context);
    // final searchProvider = Provider.of<SearchProvider>(context);
    // final infoProductScannerProvider = Provider.of<InfoProductScannerProvider>(context);
    // final valuesConsultDetailShoe = Provider.of<ValuesConsultDetailShoe>(context);

    // String imageProduct = widget.pathImage;
    // String discount = (((widget.price - widget.offerPrice) / widget.price) * 100).toStringAsFixed(0);
    // bool existOffert = ((!_isLoadingUpdateInfo) && (widget.offerPrice < widget.price && widget.offerPrice != 0));

    // bool existTalla = !(widget.talla == "00.0" || widget.talla == "0.0" || widget.talla == "0" || widget.talla == "0.00");

// REVIEW - Código duplicado en consultar productos en búsqueda normal
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardPromotion(
                temporada: widget.temporada,
              ),
              const SizedBox(height: 10),
              Text(
                "Morral / Cuero - Negro",
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
              //inf del calzado descripcion del producto

              const Text("R18 R18-BT007 (39-44) - H KNIT/TPU/3D PRINTING NEGRO-41.0"),
              const Text("Footloose - H - FCH - M008"),
              //Info del SKU del calzado a consultar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // "SKU: ${widget.sku}",
                        "SKU: 1993900000 - CU: 100004929299",
                        style: robotoStyle(15, FontWeight.w400, const Color(0xff666666)),
                      ),
                      Text(
                        //   (widget.offerPrice == 0) ? "S/.${widget.price}0" : "S/.${widget.offerPrice}0",
                        "S/. 200.00",
                        style: robotoStyle(22, FontWeight.bold, AppTheme.colorSecondary),
                      )
                    ],
                  ),
                  Visibility(
                    visible: true, //existTalla,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        //"Talla: ${widget.talla}",
                        "Talla: 34",
                        style: robotoStyle(15, FontWeight.w500, Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: true, //existOffert,
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      //"Antes: S/.${widget.price.toString()}0",
                      "Antes: S/.200.00",
                      style: robotoStyle(15, FontWeight.w400, const Color(0xff666666)),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),

              const SizedBox(height: 5.0),
              Text(
                "Fecha Creación: 24-06-2024",
                style: robotoStyle(15, FontWeight.w400, Colors.black),
              ),
              const SizedBox(height: 10.0),

              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardPromotion extends StatelessWidget {
  const _CardPromotion({
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
        "Temp: $temporada",
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
        color: const Color(0xffE2ADF2),
        border: Border.all(
          color: const Color(0xff654597),
          width: 2.0,
        ),
      ),
      child: const Center(
        child: Text('Imagen no disponible',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xff07111D),
            )),
      ),
    );
  }
}

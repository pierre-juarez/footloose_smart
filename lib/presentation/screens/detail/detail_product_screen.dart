import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
// import 'package:footloose_puntodeventa/src/data/api/consultForPartsSkuShoe_service.dart';
// import 'package:footloose_puntodeventa/src/data/provider/camera_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/info_scanner_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/search_provider.dart';
// import 'package:footloose_puntodeventa/src/domian/models/forPartsShoe_model.dart';
// import 'package:footloose_puntodeventa/src/ui/common/style.dart';
// import 'package:footloose_puntodeventa/src/ui/common/textStyle.dart';
// import 'package:footloose_puntodeventa/src/ui/detail/widgets/photoPriceAddProduc_widget.dart';
// import 'package:footloose_puntodeventa/src/ui/detail/widgets/stockCantOtherStoreFisico_widget.dart';
// import 'package:footloose_puntodeventa/src/ui/detail/widgets/stockCantOtrasTallas_widget.dart';
// import 'package:footloose_puntodeventa/src/ui/shared/customBanner.dart';
// import 'package:provider/provider.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
import 'package:footloose_tickets/presentation/widgets/navbar.dart';
import 'package:footloose_tickets/presentation/widgets/info_product.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';

class DetailProductPage extends StatelessWidget {
  static const name = "product-screen";
  // final String codMarca;
  // final String description;
  // final double offerPrice;
  // final String pathImage;
  // final double price;
  // final String sku;
  // final int stock;
  // final TextEditingController textEditingController;
  // // final DataDetail dataDetail;
  // // final List<CusOfShoe> listCusOfShoe;
  // final String categoria;
  // final String subCategoria;
  // final String talla;

  const DetailProductPage({super.key});

  /**LINK - 
   *  // required this.textEditingController,
    // required this.dataDetail,
    // required this.listCusOfShoe,
    // required this.codMarca,
    // required this.description,
    // required this.offerPrice,
    // required this.pathImage,
    // required this.price,
    // required this.stock,
    // required this.sku,
    // required this.categoria,
    // required this.subCategoria,
    // required this.talla,
    // super.key,
   * 
   */

  @override
  Widget build(BuildContext context) {
    // final searchProvider = Provider.of<SearchProvider>(context);
    // final infoProductScannerProvider = Provider.of<InfoProductScannerProvider>(context);
    // final cameraController = Provider.of<CameraController>(context);
    // final consultForPartSku = Provider.of<ConsultForPartsSkuShoeService>(context);

    // bool existTalla = (infoProductScannerProvider.dataDetail.talla != "00.0" &&
    //     infoProductScannerProvider.dataDetail.talla != "00" &&
    //     infoProductScannerProvider.dataDetail.talla != "0.0" &&
    //     infoProductScannerProvider.dataDetail.talla != "0");

    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.colorSecondary,
            onPressed: () async {
              // Navigator.pop(context);
              // await cameraController.mobileScannerController.start();
            },
            child: const Icon(
              FontAwesomeIcons.barcode,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      NavbarHome(onTap: () {
                        redirectToPage("/home");
                      }),
                      const SizedBox(height: 21.0),
                      const InfoProduct(
                        temporada: "Invi",
                      )
                      // PhotoPriceAddProducto(
                      //   codMarca: infoProductScannerProvider.dataDetail.marca!, //dataDetail.imagenMarca.toString(),
                      //   description: infoProductScannerProvider.dataDetail.descripcion!, //dataDetail.descripcion.toString(),
                      //   offerPrice: infoProductScannerProvider.dataDetail.precioOferta!, //dataDetail.precioOferta!,
                      //   pathImage:
                      //       infoProductScannerProvider.dataDetail.enlaceProducto!, //dataDetail.enlaceProducto.toString(),
                      //   price: infoProductScannerProvider.dataDetail.precio!, //dataDetail.precio!,
                      //   sku: infoProductScannerProvider.dataDetail.sku!, //dataDetail.sku.toString(),
                      //   stock: infoProductScannerProvider.dataDetail.stockTienda!, //dataDetail.stockTienda!,
                      //   dataDetail: dataDetail,
                      //   listCusOfShoe: infoProductScannerProvider.listCusOfShoe,
                      //   categoria: infoProductScannerProvider.dataDetail.categoria!,
                      //   subcategoria: infoProductScannerProvider.dataDetail.subCategoria!,
                      //   talla: infoProductScannerProvider.dataDetail.talla!,
                      // ),
                      ,
                      const SizedBox(height: 20.0),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: const ButtonPrimary(validator: false, title: "Imprimir"))
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

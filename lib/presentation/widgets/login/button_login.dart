// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';
// import 'package:provider/provider.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:footloose_puntodeventa/src/data/api/api.dart';
// import 'package:footloose_puntodeventa/src/data/provider/cart_provider.dart';
// import 'package:footloose_puntodeventa/src/data/provider/credenciales_provider.dart';
// import 'package:footloose_puntodeventa/src/domian/models/promotions/responseValidatorStore.dart';
// import 'package:footloose_puntodeventa/src/helpers/functions.dart';
// import 'package:footloose_puntodeventa/src/helpers/helpers.dart';
// import 'package:footloose_puntodeventa/src/ui/home/pages/devicePage/deviceHome_page.dart';
// import 'package:footloose_puntodeventa/src/ui/shared/buttonPrimary.dart';
// import 'package:crypto/crypto.dart';

class ButtonInitLogin extends StatelessWidget {
  const ButtonInitLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final credencialesProvider = Provider.of<CredencialesProvider>(context);
    // final authService = Provider.of<LoginServiceWithToken>(context);
    // final detailTiendaCajaService = Provider.of<DetailTiendaCajaService>(context);
    // final signInService = Provider.of<SignInService>(context);
    // final validatorStore = Provider.of<ValidatorStore>(context);
    // final cartProvider = Provider.of<CartProvider>(context);

    // String _encriptPassword(password) {
    //   return sha512.convert(utf8.encode(password)).toString().toUpperCase().substring(0, 100);
    // }

    // Future<void> _registerDataStore(DetailTiendaCajaService detailTiendaCajaService) async {
    //   //guardo los datos de la tienda aqui para poder obtenerlo
    //   await DBService.db.regitrarDatosTienda(detailTiendaCajaService.tienda);
    //   //! PARA MODO PRODUCCION MOVER AL INDEX caja[0]  --- desarrollo [1]
    //   await DBService.db.registrarDatosBoleta(detailTiendaCajaService.caja[0]);
    //   //! PARA MODO PRODUCCION MOVER AL INDEX caja[1] --- desarrollo [0]
    //   await DBService.db.registrarDatosFactura(detailTiendaCajaService.caja[1]);
    //   //* GUARDANDO DATOS DE NOTA DE CREDITO PARA BOLETA Y FACTURA
    //   await DBService.db.registrarDatosNotaCreditoBoleta(detailTiendaCajaService.caja[2]);
    //   await DBService.db.registrarDatosNotaCreditoFactura(detailTiendaCajaService.caja[3]);
    // }

    // void _continueProcess(DetailTiendaCajaService detailTiendaCajaService) {
    //   int? storeCode = detailTiendaCajaService.badResponseDetailCajaTiendaModel.code ?? 404;
    //   String title = "ADVERTENCIA: $storeCode";
    //   String messageLogin = (storeCode == 500)
    //       ? "Ocurrió un error en el registro del ID android"
    //       : "Ocurrió un error inesperado notificar a soporte";
    //   String textContents =
    //       (detailTiendaCajaService.badResponseDetailCajaTiendaModel.msg ?? messageLogin) + ".  Usarás la app solo para consultas";
    //   String textButton = "${(storeCode == 500) ? "Ingresar" : "Continuar"} igualmente";

    //   _registerDataAndNavigate(context, detailTiendaCajaService,
    //       alertTitle: title, alertMessage: textContents, alertButtonLabel: textButton);
    // }

    // Future<void> _login(LoginServiceWithToken authService) async {
    //   authService.outLoadingLogin = true;

    //   credencialesProvider.androidId = "d8717c823081b284";
    //   credencialesProvider.codTienda = await SignInService.getCodTienda();
    //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    //   AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    //   String brand = androidDeviceInfo.brand;

    //   await signInService.saveBrandDevice(brand);

    //   credencialesProvider.brandDevice = await SignInService.getBrand();

    //   final String encryptPass = _encriptPassword(credencialesProvider.clave);

    //   final loginStatus = await authService.login(
    //     credencialesProvider.usuario,
    //     encryptPass,
    //     credencialesProvider.androidId,
    //   );

    //   FocusScope.of(context).unfocus(); //quitar el teclado cuando se ya  se ingreso el los datos

    //   if (loginStatus && authService.isConnetLogin == true && authService.errorServidor == false) {
    //     String token = await LoginServiceWithToken.getToken();
    //     authService.tokenInApp = token;

    //     String tda = credencialesProvider.codTienda.substring(1);

    //     //*LLAMADO A LA API DE VERIFICACION DE QUE SI LA TIENDA PUEDE APLICAR PROMOCIONES
    //     final DatumValidatorStore datumValidatorStore = await validatorStore.validatorStoreService(tda);
    //     cartProvider.isStoreAvaliblePromotion = datumValidatorStore.activo;

    //     bool isOkGetInfoOfTiendaCaja = await detailTiendaCajaService.consultDetailTiendaCaja(tda, token);

    //     await _registerDataStore(detailTiendaCajaService);

    //     if (isOkGetInfoOfTiendaCaja) {
    //       _registerDataAndNavigate(context, detailTiendaCajaService);
    //     } else {
    //       _continueProcess(detailTiendaCajaService);
    //     }
    //   } else if (!loginStatus && authService.isConnetLogin && !authService.errorServidor) {
    //     alertError(context, errorMessage: await getErrorJSON("E002"));
    //   } else if (!loginStatus && authService.isConnetLogin && authService.errorServidor) {
    //     alertError(context, errorMessage: await getErrorJSON("E003"));
    //   } else if (!loginStatus &&
    //       authService.isConnetLogin &&
    //       authService.conexionLentaServidorLogin &&
    //       !authService.errorServidor) {
    //     alertError(context, errorMessage: await getErrorJSON("E004"));
    //   } else if (!loginStatus && !authService.isConnetLogin) {
    //     alertError(context, errorMessage: await getErrorJSON("E005"));
    //   } else {
    //     if (authService.isConnetLogin) {
    //       if (!authService.errorServidor) {
    //         alertError(context, errorMessage: await getErrorJSON("E002"));
    //       } else if (authService.conexionLentaServidorLogin && !authService.errorServidor) {
    //         alertError(context, errorMessage: await getErrorJSON("E003"));
    //       } else {
    //         alertError(context, errorMessage: await getErrorJSON("E004"));
    //       }
    //     } else {
    //       alertError(context, errorMessage: await getErrorJSON("E005"));
    //     }
    //   }

    //   authService.outLoadingLogin = false;
    // }

    // Future<void> _handleTap(LoginServiceWithToken authService) async {
    //   if (!authService.outLoadingLogin) {
    //     await _login(authService);
    //   }
    // }

    return GestureDetector(
      onTap: () => (),
      // _handleTap(authService),
      child: const ButtonPrimary(validator: false, title: "Iniciar sesión"), //  authService.outLoadingLogin
    );
  }

  // void _registerDataAndNavigate(
  //   BuildContext context,
  //   DetailTiendaCajaService detailTiendaCajaService, {
  //   String alertTitle = "",
  //   String alertMessage = "",
  //   String alertButtonLabel = "",
  // }) async {
  //   await DBService.db.regitrarDatosTienda(detailTiendaCajaService.tienda);
  //   await DBService.db.registrarDatosBoleta(detailTiendaCajaService.caja[0]);
  //   await DBService.db.registrarDatosFactura(detailTiendaCajaService.caja[1]);
  //   await DBService.db.registrarDatosNotaCreditoBoleta(detailTiendaCajaService.caja[2]);
  //   await DBService.db.registrarDatosNotaCreditoFactura(detailTiendaCajaService.caja[3]);

  //   if (alertTitle.isNotEmpty) {
  //     await alertError(
  //       context,
  //       errorMessage: alertMessage,
  //       buttonText: alertButtonLabel,
  //     );
  //   }
  //   navigateToPushReplacement(context, DeviceHomePage());
  // }
}

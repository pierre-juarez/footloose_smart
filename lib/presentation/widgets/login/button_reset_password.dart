import 'package:flutter/material.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
// import 'package:provider/provider.dart';
// import 'package:footloose_puntodeventa/src/data/api/sendEmail_service.dart';
// import 'package:footloose_puntodeventa/src/data/api/verify_service.dart';
// import 'package:footloose_puntodeventa/src/data/provider/credenciales_provider.dart';
// import 'package:footloose_puntodeventa/src/helpers/helpers.dart';
// import 'package:footloose_puntodeventa/src/ui/common/common.dart';
// import 'package:footloose_puntodeventa/src/ui/login/pages/resetPass_page.dart';

class ButtonResetPassword extends StatelessWidget {
  const ButtonResetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final credenciales = Provider.of<CredencialesProvider>(context);
    // final verifyProvider = Provider.of<VerifyService>(context);
    // final sendEmail = Provider.of<SendEmailService>(context);

    // Future<void> _recoveryPassword(BuildContext context, VerifyService verifyProvider) async {
    //   final verify = await verifyProvider.verifyUserCode(credenciales.usuario);

    //   FocusScope.of(context).unfocus();
    //   if (verify) {
    //     final String name = verifyProvider.userVerifyCode.nombre.toString() +
    //         verifyProvider.userVerifyCode.paterno.toString() +
    //         verifyProvider.userVerifyCode.materno.toString();
    //     final String email = verifyProvider.userVerifyCode.email.toString();

    //     sendEmail.sendEmail(name, email);
    //     navigateToPush(context, ResetPassPage());
    //   } else {
    //     alertError(context, errorMessage: await getErrorJSON("E007"));
    //   }
    // }

    // Future<void> _handleTap(String userCode, VerifyService verifyService) async {
    //   if (userCode.length == 0) {
    //     alertError(context, errorMessage: await getErrorJSON("E008"));
    //   }

    //   if (userCode.length == 6 && !verifyService.verificando) {
    //     await _recoveryPassword(context, verifyProvider);
    //   }
    // }

    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "¿Olvidaste tu contraseña?",
            style: robotoStyle(15, FontWeight.normal, AppTheme.colorStyleText),
          ),
          const SizedBox(width: 5),
          InkWell(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Restablécela acá",
                  style: robotoStyle(15, FontWeight.bold, AppTheme.colorSecondary),
                ),
              ),
              onTap: () async => ()
              //await _handleTap(credenciales.usuario, verifyProvider),
              )
        ],
      ),
    );
  }
}

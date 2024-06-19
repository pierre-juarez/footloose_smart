import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
import 'package:footloose_tickets/presentation/widgets/logo_widget.dart';
import 'package:footloose_tickets/presentation/widgets/textwidget.dart';

class SplashScreen extends ConsumerWidget {
  static const name = 'splash-screen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: FutureBuilder(
          future: checkLogin(context, ref),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageLogoFootloose(),
                  TextWidgetInput(
                    text: "Verificando autenticación...",
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colorStyleText,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future checkLogin(BuildContext context, WidgetRef ref) async {
    final auth = ref.read(authProvider);

    final logeado = await auth.isLoggedIn();

    if (!auth.isConnect) {
      await redirectToPage("/login");
    } else {
      String route = (logeado) ? "/home" : "/login";
      await redirectToPage(route);
    }
  }
}

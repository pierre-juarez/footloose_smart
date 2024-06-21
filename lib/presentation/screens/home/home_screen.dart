import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/camera/camera_provider.dart';
import 'package:footloose_tickets/presentation/widgets/button_primary.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: _PageHome(),
    );
  }
}

class _PageHome extends ConsumerWidget {
  const _PageHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _NavbarHome(),
          Expanded(
            child: _ConsultPage(camera: camera),
          ),
        ],
      ),
    );
  }
}

class _NavbarHome extends StatelessWidget {
  const _NavbarHome();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.infinity,
      decoration: BoxDecoration(color: AppTheme.backgroundColor),
      child: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Icon(
                      FontAwesomeIcons.bars,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Impresión de Etiquetas",
                  style: robotoStyle(20, FontWeight.w400, Colors.white),
                ),
                Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ConsultPage extends StatelessWidget {
  const _ConsultPage({
    required this.camera,
  });

  final CameraProvider camera;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 220),
      child: Column(
        children: [
          Text(
            "Consultar Producto",
            style: robotoStyle(28, FontWeight.w500, AppTheme.backgroundColor),
          ),
          const SizedBox(height: 19),
          Text(
            "Pulsa 'Escanear' para empezar a escanear el código de barras del producto.",
            style: robotoStyle(14, FontWeight.w400, const Color(0xff7C7979).withOpacity(0.8)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 80),
          InkWell(
            onTap: () async {
              //FIXME validar funcionalidad del scanner, solo se ejecuta consulta una vez, luego falla...
              try {
                print(
                    "🚀 ~ file: consultaPage.dart ~ line: 41 ~ cameraController.mobileScannerController.isStarting: ${camera.mobileScannerController.value.isRunning}");
                // await camera.mobileScannerController.stop();
                // if (!camera.mobileScannerController.autoStart) {
                await camera.mobileScannerController.start();
                // }
                //navigateToPush(context, ScannerPage());
                await redirectToPage("/scan");
              } catch (e) {
                await camera.mobileScannerController.stop();
                print("Error al ir a la página de Escanner: $e");
              }
            },
            child: const ButtonPrimary(
              validator: false,
              title: "Escanear producto",
              icon: FontAwesomeIcons.qrcode,
            ),
          )
        ],
      ),
    );
  }
}

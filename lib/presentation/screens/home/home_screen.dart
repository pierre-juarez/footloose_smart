import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footloose_tickets/config/helpers/helpers.dart';
import 'package:footloose_tickets/config/helpers/roboto_style.dart';
import 'package:footloose_tickets/config/helpers/verify_bluetooth.dart';
import 'package:footloose_tickets/config/theme/app_theme.dart';
import 'package:footloose_tickets/presentation/providers/camera/camera_provider.dart';
import 'package:footloose_tickets/presentation/providers/login/auth_provider.dart';
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
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppTheme.backgroundColor,
        title: Text(
          "Impresión de etiquetas",
          style: robotoStyle(19, FontWeight.w400, Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
                onTap: () {
                  showOptions(context, auth);
                },
                child: const Icon(FontAwesomeIcons.arrowRightToBracket)),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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

class _ConsultPage extends StatefulWidget {
  const _ConsultPage({
    required this.camera,
  });

  final CameraProvider camera;

  @override
  State<_ConsultPage> createState() => _ConsultPageState();
}

class _ConsultPageState extends State<_ConsultPage> {
  bool loadingScan = false;

  Future<void> navigateToScan() async {
    setState(() {
      loadingScan = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      print(
          "🚀 ~ file: consultaPage.dart ~ line: 41 ~ cameraController.mobileScannerController.isStarting: ${widget.camera.mobileScannerController.value.isRunning}");
      await widget.camera.mobileScannerController.start();
      await redirectToPage("/scan");
      setState(() {
        loadingScan = false;
      });
    } catch (e) {
      await widget.camera.mobileScannerController.stop();
      print("Error al ir a la página de Escanner: $e");
      setState(() {
        loadingScan = false;
      });
    }
  }

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
            onTap: () async => navigateToScan(),
            child: ButtonPrimary(
              validator: loadingScan,
              title: "Escanear producto",
              icon: FontAwesomeIcons.qrcode,
            ),
          )
        ],
      ),
    );
  }
}

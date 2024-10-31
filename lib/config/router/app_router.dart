import 'dart:convert';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/presentation/screens/detail/detail_product_screen.dart';
import 'package:footloose_tickets/presentation/screens/home/home_screen.dart';
import 'package:footloose_tickets/presentation/screens/home/splash_screen.dart';
import 'package:footloose_tickets/presentation/screens/login/login_screen.dart';
import 'package:footloose_tickets/presentation/screens/scan/preview_print_screen.dart';
import 'package:footloose_tickets/presentation/screens/scan/print_screen.dart';
import 'package:footloose_tickets/presentation/screens/scan/scan_product_screen.dart';
import 'package:footloose_tickets/presentation/widgets/scan/onscreen_keyboard/onscreen_keyboard.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: SplashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/scan',
      name: ScanerPage.name,
      builder: (context, state) {
        final urlScan = state.uri.queryParameters['urlScan']!;
        final requestScan = state.uri.queryParameters['typeRequest']!;
        return ScanerPage(urlScan: urlScan, typeRequest: requestScan);
      },
    ),
    GoRoute(
      path: '/product',
      name: DetailProductPage.name,
      builder: (context, state) {
        final etiquetaJson = state.uri.queryParameters['etiqueta']!;
        final decodedJson = jsonDecode(etiquetaJson);
        final etiqueta = EtiquetaModel.fromJson(decodedJson);
        return DetailProductPage(etiqueta: etiqueta);
      },
    ),
    GoRoute(
      path: '/preview',
      name: PreviewPrintScreen.name,
      builder: (context, state) {
        return const PreviewPrintScreen();
      },
    ),
    GoRoute(
      path: '/print',
      name: PrintScreen.name,
      builder: (context, state) {
        final imagesJsonEncoded = state.uri.queryParameters['images'];
        final List<dynamic> imagesJsonList = jsonDecode(Uri.decodeComponent(imagesJsonEncoded!));

        final List<Map<String, dynamic>> imagePrintsList = imagesJsonList.map((item) {
          return {
            'image': base64Decode(item['image']),
            'numberprints': item['numberprints'],
          };
        }).toList();

        return PrintScreen(imagePrintsList: imagePrintsList);
      },
    ),
    GoRoute(
      path: '/keyboard-screen',
      name: OnscreenKeyboard.name,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;

        if (extra == null ||
            !extra.containsKey('mobileScannerController') ||
            !extra.containsKey('urlScan') ||
            !extra.containsKey('typeRequest')) {
          return throw Exception("Missing parameters");
        }

        final mobileScannerController = extra['mobileScannerController'] as MobileScannerController;
        final urlScan = extra['urlScan'] as String;
        final typeRequest = extra['typeRequest'] as String;

        return OnscreenKeyboard(
          mobileScannerController: mobileScannerController,
          urlScan: urlScan,
          typeRequest: typeRequest,
        );
      },
    ),
  ],
);

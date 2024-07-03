import 'dart:convert';
import 'package:footloose_tickets/infraestructure/models/etiqueta_model.dart';
import 'package:footloose_tickets/infraestructure/models/product_detail_model.dart';
import 'package:footloose_tickets/presentation/screens/configuration/configuration_screen.dart';
import 'package:footloose_tickets/presentation/screens/detail/detail_product_screen.dart';
import 'package:footloose_tickets/presentation/screens/home/home_screen.dart';
import 'package:footloose_tickets/presentation/screens/home/splash_screen.dart';
import 'package:footloose_tickets/presentation/screens/login/login_screen.dart';
import 'package:footloose_tickets/presentation/screens/scan/preview_print_screen.dart';
import 'package:footloose_tickets/presentation/screens/scan/print_screen.dart';
import 'package:footloose_tickets/presentation/screens/scan/queue_print_screen.dart';
import 'package:footloose_tickets/presentation/screens/scan/scan_product_screen.dart';
import 'package:go_router/go_router.dart';

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
      builder: (context, state) => const ScanerPage(),
    ),
    GoRoute(
      path: '/product',
      name: DetailProductPage.name,
      builder: (context, state) {
        final productJson = state.uri.queryParameters['productJson']!;
        final decodedJson = jsonDecode(productJson);
        final product = ProductDetailModel.fromJson(decodedJson);
        return DetailProductPage(product: product);
      },
    ),
    GoRoute(
      path: '/preview',
      name: PreviewPrintScreen.name,
      builder: (context, state) {
        final etiquetaJson = state.uri.queryParameters['etiqueta']!;
        final decodedJson = jsonDecode(etiquetaJson);
        final etiqueta = EtiquetaModel.fromJson(decodedJson);
        return PreviewPrintScreen(etiqueta: etiqueta);
      },
    ),
    GoRoute(
      path: '/print',
      name: PrintScreen.name,
      builder: (context, state) {
        final imageBytesBase64 = state.uri.queryParameters['image'];
        final imageBytes = base64Decode(imageBytesBase64!);
        return PrintScreen(imageBytes: imageBytes);
      },
    ),
    GoRoute(
      path: '/configuration',
      name: ConfigurationScreen.name,
      builder: (context, state) => const ConfigurationScreen(),
    ),
    GoRoute(
      path: '/review-queue',
      name: QueuePrintScreen.name,
      builder: (context, state) {
        final etiquetasJson = state.uri.queryParameters['etiquetas']!;
        final decodedJson = jsonDecode(etiquetasJson) as List<dynamic>;
        final etiquetas = decodedJson.map((json) => EtiquetaModel.fromJson(json as Map<String, dynamic>)).toList();
        return QueuePrintScreen(etiquetas: etiquetas);
      },
    ),
  ],
);

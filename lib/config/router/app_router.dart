import 'dart:convert';
import 'package:footloose_tickets/infraestructure/models/product_model.dart';
import 'package:footloose_tickets/presentation/screens/detail/detail_product_screen.dart';
import 'package:footloose_tickets/presentation/screens/home/home_screen.dart';
import 'package:footloose_tickets/presentation/screens/home/splash_screen.dart';
import 'package:footloose_tickets/presentation/screens/login/login_screen.dart';
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
        final product = ProductModel.fromJson(decodedJson);
        return DetailProductPage(productModel: product);
      },
    )
  ],
);

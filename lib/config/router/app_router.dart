import 'package:footloose_tickets/presentation/screens/home/home_screen.dart';
import 'package:footloose_tickets/presentation/screens/home/splash_screen.dart';
import 'package:footloose_tickets/presentation/screens/login/login_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
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
  )
]);

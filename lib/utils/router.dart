import 'package:go_router/go_router.dart';
import 'package:just_chat/screens/auth.dart';
import 'package:just_chat/screens/home.dart';

abstract class RouteName{
  static const auth = '/auth';
  static const home = '/home';
}

final GoRouter appRouter = GoRouter(
  initialLocation: RouteName.auth,
  routes: [
    GoRoute(path:RouteName.auth, builder: (context, state) => const AuthScreen()),
    // GoRoute(path: RouteName.home, builder: (context, state) => const HomeScreen()),
  ],
);

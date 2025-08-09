import 'package:go_router/go_router.dart';
import 'package:allergy_free/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/change_password',
  routes: [
    GoRoute(
      name: HomeScreen.screenName,
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: ProfileScreen.screenName,
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      name: SettingsScreen.screenName,
      path: '/settings',
      builder: (context, state) => SettingsScreen(),
    ),
    GoRoute(
      name: TransitionScreen.screenName,
      path: '/transition',
      builder: (context, state) => TransitionScreen(),
    ),
    GoRoute(
      name: LoginScreen.screenName,
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: ChangePasswordScreen.screenName,
      path: '/change_password',
      builder: (context, state) => ChangePasswordScreen(),
    ),
  ],
);

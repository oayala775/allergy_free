import 'package:allergy_free/config/utils/helpers/results_state.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:allergy_free/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
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
    GoRoute(
      name: TermsAndConditionsScreen.screenName,
      path: '/terms_and_conditions',
      builder: (context, state) => TermsAndConditionsScreen(),
    ),
    GoRoute(
      name: SignUpScreen.screenName,
      path: '/sign_up',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      name: SelectAvatarScreen.screenName,
      path: '/select_avatar',
      builder: (context, state) => SelectAvatarScreen(),
    ),
    GoRoute(
      name: ResultsScreen.screenName,
      path: '/results_screen',
      builder: (context, state) {
        final extraData = state.extra as ResultsState?;
        if (extraData == null) return Placeholder();
        return ResultsScreen(resultsState: extraData);
      },
    ),
  ],
);

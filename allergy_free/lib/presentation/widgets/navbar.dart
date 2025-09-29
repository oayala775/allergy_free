import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/presentation/providers/index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Navbar extends ConsumerWidget {
  const Navbar({super.key});

  int? getCurrentIndex(BuildContext context, WidgetRef ref) {
    final String location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      case '/settings':
        return 0;
      case '/':
        return 1;
      case '/profile':
        return 2;
    }
  }

  void onItemTapped(BuildContext context, int value, WidgetRef ref) {
    switch (value) {
      case 0:
        ref.read(navBarIndexProvider.notifier).state = 0;
        GoRouter.of(context).pushNamed('settings_screen');
        break;
      case 1:
        ref.read(navBarIndexProvider.notifier).state = 1;
        GoRouter.of(context).pushNamed('home_screen');
        break;
      case 2:
        ref.read(navBarIndexProvider.notifier).state = 2;
        GoRouter.of(context).pushNamed('profile_screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int lastIndex = ref.watch(navBarIndexProvider.notifier).state;

    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      fixedColor: CustomColors.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: getCurrentIndex(context, ref) ?? lastIndex,
      onTap: (value) => onItemTapped(context, value, ref),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu, size: 50),
          label: 'Settings Screen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 50),
          label: 'Home Screen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 50),
          label: 'Profile Screen',
        ),
      ],
    );
  }
}

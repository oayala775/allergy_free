import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/presentation/providers/index_provider.dart';
import 'package:allergy_free/presentation/screens/home/home_screen.dart';
import 'package:allergy_free/presentation/screens/profile/profile_screen.dart';
import 'package:allergy_free/presentation/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Navbar extends ConsumerWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screens = const [
      SettingsScreen.screenName,
      HomeScreen.screenName,
      ProfileScreen.screenName,
    ];
    int selectedIndex = ref.watch(navBarIndexProvider);
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      fixedColor: CustomColors.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (value) {
        ref.read(navBarIndexProvider.notifier).state = value;
        GoRouter.of(context).pushNamed(screens[value]);
      },
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu, size: 50),
          label: 'something',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home, size: 50),
          label: 'something',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person, size: 50),
          label: 'something',
        ),
      ],
    );
  }
}

import 'package:allergy_free/presentation/widgets/appbar.dart';
import 'package:allergy_free/presentation/widgets/navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String screenName = "home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Appbar(), body: const Text("Home screen"), bottomNavigationBar: Navbar());
  }
}

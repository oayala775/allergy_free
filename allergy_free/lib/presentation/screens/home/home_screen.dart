import 'package:allergy_free/presentation/widgets/allergen_dropdown_menu.dart';
import 'package:allergy_free/presentation/widgets/back_arrow_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String screenName = "home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackArrowButton(), title: Text(screenName)),
      body: Center(
        child: AllergenDropdownMenu(width: 350, height: 60), // Aquí se muestra el dropdown
      ),
    );
  }
}

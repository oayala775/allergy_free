import 'package:allergy_free/presentation/widgets/appbar.dart';
import 'package:allergy_free/presentation/widgets/navbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const String screenName = "profile_screen";
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: const Text("Profile screen"),
      bottomNavigationBar: Navbar(),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const String screenName = "profile_screen";
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(screenName)));
  }
}

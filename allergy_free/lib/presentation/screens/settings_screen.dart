import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const String screenName = "settings_screen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(screenName)));
  }
}

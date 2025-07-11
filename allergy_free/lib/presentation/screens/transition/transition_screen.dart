import 'package:flutter/material.dart';

class TransitionScreen extends StatelessWidget {
  static const String screenName = "transition_screen";
  const TransitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(screenName)));
  }
}

import 'package:allergy_free/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(0.0, 0.0, 20.0, 0.0),
      child: Logo(height: 31, width: 105),
    );
  }
}
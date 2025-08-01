import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/presentation/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: CustomColors.primary,
      ),
    );
  }
}

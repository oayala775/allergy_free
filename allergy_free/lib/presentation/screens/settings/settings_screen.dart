import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/presentation/widgets/appbar.dart';
import 'package:allergy_free/presentation/widgets/custom_text_button.dart';
import 'package:allergy_free/presentation/widgets/navbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const String screenName = "settings_screen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: const Text('Settings', style: CustomTextStyles.title),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: const Text('Account', style: CustomTextStyles.title),
            ),
          ),
          CustomTextButton(
            text: 'Edit Profile',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
          ),
          CustomTextButton(
            text: 'Change password',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
          ),
          CustomTextButton(
            text: 'Logout',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: const Text('Support', style: CustomTextStyles.title),
            ),
          ),
          CustomTextButton(
            text: 'FAQ',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
          ),
          CustomTextButton(
            text: 'Suggestions',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}

import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class SettingsScreen extends StatelessWidget {
  static const String screenName = "settings_screen";
  const SettingsScreen({super.key});

  // Función para mostrar el diálogo de confirmación de cierre de sesión  void _showLogoutDialog(BuildContext context) {
  void _showLogoutDialog(BuildContext context) {
    ConfirmationDialog.show(
      context: context,
      title: "Are you sure you want to log out?",
      titleStyle: CustomTextStyles.greyPopupTitle, // Solo esto personalizas
      onConfirm: () {
        // Navegar al login después de confirmar
        context.pushNamed(LoginScreen.screenName);
      },
      onCancel: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text('Settings', style: CustomTextStyles.title),
            ),
          ),
          _CustomCheckbox(
            accepted: true,
            onChanged: (value) {},
            buttonText: 'Color Scheme',
            width: 400,
            height: 64,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text('Account', style: CustomTextStyles.title),
            ),
          ),
          CustomTextButton(
            text: 'Edit Profile',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
            onPressed: () {
              GoRouter.of(context).pushNamed(ProfileScreen.screenName);
            },
          ),
          CustomTextButton(
            text: 'Change Password',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
            onPressed: () {
              GoRouter.of(context).pushNamed(ChangePasswordScreen.screenName);
            },
          ),
          CustomTextButton(
            text: 'Log Out',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
            onPressed: () => _showLogoutDialog(context),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text('Support', style: CustomTextStyles.title),
            ),
          ),
          CustomTextButton(
            text: 'FAQ',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
            // TODO: Add link to FAQ page
          ),
          CustomTextButton(
            text: 'Suggestions',
            width: 400,
            height: 64,
            customTextStyle: CustomTextStyles.whiteText700,
            // TODO: Add link to suggestions forms
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}

class _CustomCheckbox extends StatelessWidget {
  final bool accepted;
  final ValueChanged<bool> onChanged;
  final String buttonText;
  final double width;
  final double height;
  const _CustomCheckbox({
    required this.accepted,
    required this.onChanged,
    required this.buttonText,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          border: BoxBorder.all(color: CustomColors.primary, width: 4.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 14.0, 0.0, 14.0),
                child: Text(
                  buttonText,
                  style: CustomTextStyles.inputText,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Checkbox(
                value: accepted,
                activeColor: CustomColors.primary,
                onChanged: (value) {
                  onChanged(value ?? false);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  side: const BorderSide(width: 8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

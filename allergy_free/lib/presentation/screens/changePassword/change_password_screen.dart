import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String screenName = "change_password_screen";
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: const _ChangePasswordContent(),
      bottomNavigationBar: const Navbar(),
    );
  }
}

class _ChangePasswordContent extends StatelessWidget {
  const _ChangePasswordContent();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: const IntrinsicHeight(child: ChangePasswordForm()),
          ),
        );
      },
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Create New\nPassword",
              style: CustomTextStyles.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              text: "Current Password",
              inputType: TextInputType.visiblePassword,
            ),
            const CustomTextField(
              text: "New Password",
              inputType: TextInputType.visiblePassword,
            ),
            const CustomTextField(
              text: "Confirm New Password",
              inputType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              text: "Change Password",
              width: double.infinity,
              height: 64,
              onPressed: _changePassword,
              customTextStyle: CustomTextStyles.whiteText700,
            ),
            const Flexible(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  //En caso de que se cambie la contraseña correctamente, mostrar este pop-up
  void _success(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomDialog(
        title: "Password changed successfully",
        titleStyle: CustomTextStyles.greenPopupTitle,
        message: "Your new password has been saved.",
        messageStyle: CustomTextStyles.inputText,
        buttonText: 'Okey',
        buttonTextStyle: CustomTextStyles.whiteText700,
        buttonColor: CustomColors.primary,
        onButtonPressed: () {
          // Ir a la pantalla anterior después de cerrar el diálogo
          GoRouter.of(context).pop();
        },
      ),
    );
  }

  //En caso de que no se pueda cambiar la contraseña, mostrar este pop-up
  void _error(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomDialog(
        title: "Something went wrong",
        titleStyle: CustomTextStyles.greyPopupTitle,
        message: "We couldn't update your password. Please try again later.",
        messageStyle: CustomTextStyles.inputText,
        buttonText: 'Okey',
        buttonTextStyle: CustomTextStyles.whiteText700,
        buttonColor: CustomColors.primary,
        onButtonPressed: () {
          // Ir a la pantalla anterior después de cerrar el diálogo
          GoRouter.of(context).pop();
        },
      ),
    );
  }


  void _changePassword() {
    // Hide keyboard when button is pressed
    FocusScope.of(context).unfocus();
    _success(context);

    // TODO: Validate forms and implement password change logic
    // if (_formKey.currentState?.validate() ?? false) {
    //   // Form is valid, proceed with password change
    // }
  }
}

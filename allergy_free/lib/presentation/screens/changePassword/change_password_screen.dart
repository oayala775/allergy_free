import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/presentation/widgets/app_name_widget.dart';
import 'package:allergy_free/presentation/widgets/back_arrow_button.dart';
import 'package:allergy_free/presentation/widgets/custom_text_button.dart';
import 'package:allergy_free/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String screenName = "change_password_screen";
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Scaffold(
        appBar: AppBar(
          leading: BackArrowButton(),
          actions: [AppNameWidget()],
        ),
        body: SingleChildScrollView(
          child: IntrinsicHeight(child: ChangePasswordForm()),
        ),
      ),
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
            SizedBox(height: size.height * 0.1),
            Text(
              "Create New\nPassword",
              style: CustomTextStyles.title,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),
            CustomTextField(
              text: "Current Password",
              inputType: TextInputType.visiblePassword,
            ),
            CustomTextField(
              text: "New Password",
              inputType: TextInputType.visiblePassword,
            ),
            CustomTextField(
              text: "Confirm New Password",
              inputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: size.height * 0.02),
            CustomTextButton(
              text: "Change Password",
              width: double.infinity,
              height: 64,
              onPressed: () {
                // queda pendiente validar el formuario
              },
              customTextStyle: CustomTextStyles.whiteText700,
            ),
            SizedBox(height: size.height * 0.04),
            // falta agregar el navbar
          ],
        ),
      ),
    );
  }
}

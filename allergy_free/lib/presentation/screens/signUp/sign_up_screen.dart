import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/presentation/widgets/appbar.dart';
import 'package:allergy_free/presentation/widgets/custom_text_field.dart';
import 'package:allergy_free/presentation/widgets/custom_text_button.dart';
import 'package:allergy_free/presentation/widgets/allergen_dropdown_menu.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  static const String screenName = "sign_up_screen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(child: AvatarSelectButton()),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      text: 'Enter your username',
                      inputType: TextInputType.text,
                    ),
                    CustomTextField(
                      text: 'Enter your password',
                      inputType: TextInputType.visiblePassword,
                    ),
                    CustomTextField(
                      text: 'Re-enter your password',
                      inputType: TextInputType.visiblePassword,
                    ),
                    CustomTextField(
                      text: 'Enter your age',
                      inputType: TextInputType.number,
                    ),
                    AllergenDropdownMenu(width: double.infinity, height: 60),
                    TermsAndConditionsBox(
                      accepted: _acceptedTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptedTerms = value;
                        });
                      },
                    ),
                    CustomTextButton(
                      text: 'Sign Up',
                      width: double.infinity,
                      height: 56,
                      customTextStyle: CustomTextStyles.whiteText700,
                      onPressed: () {
                        // TODO: Implementar lógica de sign up. También hay que asegurarse de que se acepten los términos y condiciones
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AvatarSelectButton extends StatelessWidget {
  const AvatarSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Dirigirse a la selección de avatar
      },
      child: DottedBorder(
        options: CircularDottedBorderOptions(
          color: CustomColors.primary,
          strokeWidth: 5,
          dashPattern: [20, 6],
          padding: const EdgeInsets.all(16.0),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Icon(Icons.add, size: 175 * 0.4, color: CustomColors.primary),
        ),
      ),
    );
  }
}

class TermsAndConditionsBox extends StatelessWidget {
  final bool accepted;
  final ValueChanged<bool> onChanged;

  const TermsAndConditionsBox({
    super.key,
    required this.accepted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary, width: 4.0),
          borderRadius: BorderRadius.circular(70.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Checkbox(
                value: accepted,
                activeColor: CustomColors.primary,
                onChanged: (value) {
                  onChanged(value ?? false);
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).push('/terms_and_conditions');
                  },
                  child: Text(
                    "Acepto los términos y condiciones",
                    style: CustomTextStyles.inputText,
                  ),
                ),
              ),
            ),
            // ),
            const SizedBox(width: 24.0),
          ],
        ),
      ),
    );
  }
}

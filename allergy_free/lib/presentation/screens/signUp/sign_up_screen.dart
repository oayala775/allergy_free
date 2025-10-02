import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';

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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    const Center(child: AvatarSelectButton()),
                    const SizedBox(height: 10.0),
                    const CustomTextField(
                      text: 'Enter your username',
                      inputType: TextInputType.text,
                    ),
                    const CustomTextField(
                      text: 'Enter your password',
                      inputType: TextInputType.visiblePassword,
                    ),
                    const CustomTextField(
                      text: 'Re-enter your password',
                      inputType: TextInputType.visiblePassword,
                    ),
                    const CustomTextField(
                      text: 'Enter your age',
                      inputType: TextInputType.number,
                    ),
                    const AllergenDropdownMenu(
                      width: double.infinity,
                      height: 66,
                    ),
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
                      height: 60,
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
        GoRouter.of(context).pushNamed("select_avatar_screen");
      },
      child: DottedBorder(
        options: const CircularDottedBorderOptions(
          color: CustomColors.primary,
          strokeWidth: 5,
          dashPattern: [20, 6],
          padding: EdgeInsets.all(16.0),
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
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 10.0),
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).push('/terms_and_conditions');
                  },
                  child: const Text(
                    "I accept the terms and conditions",
                    style: CustomTextStyles.inputText,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
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

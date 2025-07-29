import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/presentation/widgets/custom_text_field.dart';
import 'package:allergy_free/presentation/widgets/custom_text_button.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const String screenName = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // size del viewport
    final double minTopHeight =
        size.height *
        0.32; // Altura mínima del contenedor que contiene el logo y el icono
    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size.height),
          child: IntrinsicHeight(
            child: Column(
              children: [
                // Icono y logo
                Container(
                  width: double.infinity,
                  color: CustomColors.primary,
                  padding: EdgeInsets.only(top: 32, bottom: 16),
                  constraints: BoxConstraints(minHeight: minTopHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(), SizedBox(height: 16.0), Logo()],
                  ),
                ),
                // Formulario
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(64.0),
                        topRight: Radius.circular(64.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Formulary(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo/Logo_AllergyFree_blanco.png',
      width: 263,
      height: 77,
    );
  }
}

class Icon extends StatelessWidget {
  const Icon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 127,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(250),
        image: const DecorationImage(
          image: AssetImage('assets/images/icon/Icon_AllergyFree.png'),
        ),
      ),
    );
  }
}

class Formulary extends StatelessWidget {
  const Formulary({super.key});
  // Queda pendiente la validación del formulario y el manejo de errores

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Login',
                style: CustomTextStyles.titleLogin,
                textAlign: TextAlign.center,
              ),
              const CustomTextField(
                text: 'Username',
                inputType: TextInputType.text,
              ),
              const CustomTextField(
                text: 'Password',
                inputType: TextInputType.visiblePassword,
              ),
              CustomTextButton(
                text: 'Login',
                width: double.infinity,
                height: 56,
                onPressed: () {
                  print('Login button pressed');
                  context.pushNamed(HomeScreen.screenName);
                },
              ),
            ],
          ),
          const SignUpPrompt(),
        ],
      ),
    );
  }
}

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // size del viewport
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.02,
        bottom: size.height * 0.06,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Don´t have an account? ', style: CustomTextStyles.greyedText),
          GestureDetector(
            onTap: () {
              // Hay que redirigr a la pantalla de sign up
              print("Ir a sign up");
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: CustomColors.signUpLink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

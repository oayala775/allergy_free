import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:allergy_free/presentation/widgets/custom_text_field.dart';
import 'package:allergy_free/presentation/widgets/custom_text_button.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: Column(
        children: [
          // Icono y logo
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [icono(), const SizedBox(height: 16), logo()],
              ),
            ),
          ),

          // Formulario
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: formulario(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container icono() {
    return Container(
      width: 130,
      height: 127,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65),
        image: const DecorationImage(
          image: AssetImage('assets/images/icon/Icon_AllergyFree.png'),
        ),
      ),
    );
  }

  Image logo() {
    return Image.asset(
      'assets/images/logo/Logo_AllergyFree_blanco.png',
      width: 180,
      height: 60,
    );
  }

  Form formulario() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),

          const Text(
            'Login',
            style: CustomTextStyles.greenLogin,
            textAlign: TextAlign.center,
          ),

          // Username, queda pendiente crear controlador.
          const CustomTextField(
            text: 'Username',
            inputType: TextInputType.text,
          ),

          // Password, queda pendiente crear controlador
          const CustomTextField(
            text: 'Password',
            inputType: TextInputType.visiblePassword,
          ),

          // Login button
          CustomTextButton(
            text: 'Login',
            width: double.infinity,
            height: 56,
            onPressed: () {
              print('Login button pressed');
              // Queda pendiente validar formulario
              // if (_formKey.currentState?.validate() ?? false) {
              // }
              context.pushNamed(HomeScreen.screenName);
            },
          ),

          const SizedBox(height: 40),

          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Don´t have an account? ',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3A3A3A),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // queda pendiente crear vista de sign up
                  //  context.pushNamed(name)
                  print('Sign up pressed');
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w800,
                    fontSize: 16, // Same size as the other text
                    color: CustomColors.signUpLink,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

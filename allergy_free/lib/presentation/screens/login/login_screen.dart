import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  static const String screenName = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoPositionAnimation;
  late Animation<double> _formHeightAnimation;
  late Animation<double> _formOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Animación para la posición del logo
    _logoPositionAnimation = Tween<double>(
      begin: 0.4, // Comienza centrado
      end: 0.12, // Termina más abajo (12% desde arriba)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Animación para la altura del formulario
    _formHeightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Animación para la opacidad del formulario
    _formOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Iniciar animación después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Logo que se mueve hacia arriba
              Positioned(
                top: size.height * _logoPositionAnimation.value,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(),
                      const SizedBox(height: 8.0),
                      Logo(whiteLogo: true, height: 77, width: 263),
                    ],
                  ),
                ),
              ),

              // Formulario que aparece desde abajo
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: _formOpacityAnimation.value,
                  child: Container(
                    height: size.height * 0.6 * _formHeightAnimation.value,
                    constraints: BoxConstraints(
                      maxHeight: size.height * 0.6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(64.0),
                        topRight: Radius.circular(64.0),
                      ),
                    ),
                    child: _formHeightAnimation.value > 0.3
                        ? SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 24,
                              ),
                              child: Formulary(),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Login',
                style: CustomTextStyles.titleLogin,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              const CustomTextField(
                text: 'Username',
                inputType: TextInputType.text,
              ),
              const SizedBox(height: 5),
              const CustomTextField(
                text: 'Password',
                inputType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 5),
              CustomTextButton(
                text: 'Login',
                width: double.infinity,
                height: 56,
                onPressed: () {
                  // TODO: Add redirection to main screen and validation of user
                  context.pushNamed(HomeScreen.screenName);
                },
                customTextStyle: CustomTextStyles.whiteText700,
              ),
            ],
          ),
          const SizedBox(height: 5),
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
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Don´t have an account? ', style: CustomTextStyles.greyedText),
          GestureDetector(
            onTap: () {
              context.pushNamed(SignUpScreen.screenName);
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
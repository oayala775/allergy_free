import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';

class GoodResultScreen extends ConsumerStatefulWidget {
  static const String screenName = "good_result_screen";
  const GoodResultScreen({super.key});

  @override
  ConsumerState<GoodResultScreen> createState() => _GoodResultScreen();
}

class _GoodResultScreen extends ConsumerState<GoodResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //quitar la flecha
        actions: const [AppNameWidget()],
      ),
      body: const SafeArea( // Agregar SafeArea aquí
        child: _GoodResult(),
      ),
    );
  }
}

class _GoodResult extends StatelessWidget {
  const _GoodResult();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Primer texto centrado vertical y horizontalmente
          Expanded(
            child: Center(
              child: Text(
                'Allegen-free for you!',
                style: CustomTextStyles.goodResult,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          // Contenedor para elementos inferiores
          Column(
            children: [
              // Segundo texto arriba del botón
              Text(
                  'Results may not be exact. Check ingredients and consult a specialist if needed.',
                  style: CustomTextStyles.darkGrey400_14,
                  textAlign: TextAlign.center,
                ),
              // Botón en la parte inferior
              CustomTextButton(
                text: "OK",
                width: double.infinity,
                height: 64,
                onPressed: () {
                  GoRouter.of(context).pushNamed(HomeScreen.screenName);
                },
                customTextStyle: CustomTextStyles.whiteText700,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/config/utils/helpers/results_state.dart';
import 'package:allergy_free/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';

class ResultsScreen extends ConsumerStatefulWidget {
  static const String screenName = "results_screen";
  // Indicadores de resultado
  final ResultsState resultsState;

  const ResultsScreen({super.key, required this.resultsState});

  @override
  ConsumerState<ResultsScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //quitar la flecha
        actions: const [AppNameWidget()],
      ),
      body: SafeArea(
        // Agregar SafeArea aquí
        child: _Result(
          isAllergenFree: widget.resultsState.isAllergenFree,
          couldNotReadChars: widget.resultsState.isUnrecognizedText,
        ),
      ),
    );
  }
}

class _Result extends StatelessWidget {
  final bool isAllergenFree;
  final bool couldNotReadChars;

  const _Result({
    required this.isAllergenFree,
    required this.couldNotReadChars,
  });

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
                // Determinar qué mensaje mostrar
                couldNotReadChars
                    ? 'Could not read the characters. Please try again.'
                    : isAllergenFree
                    ? 'Allergen-free for you!'
                    : 'Allergen detected - not safe for you',
                style:
                    isAllergenFree
                        ? CustomTextStyles.goodResult
                        : CustomTextStyles.badResult,
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

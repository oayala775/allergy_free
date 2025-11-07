import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/config/utils/helpers/results_state.dart';
import 'package:allergy_free/presentation/providers/recognized_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransitionScreen extends ConsumerStatefulWidget {
  static const String screenName = "transition_screen";
  const TransitionScreen({super.key});

  @override
  ConsumerState<TransitionScreen> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends ConsumerState<TransitionScreen> {
  @override
  void initState() {
    super.initState();
    _startDelayedNavigation();
  }

  @override
  // TODO: Queda pendiente la transición a la página de resultados.
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Appbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ProgressBar(), Remainder()],
      ),
    );
  }

  void _startDelayedNavigation() {
    Future.delayed(Duration(seconds: 7), () {
      if (mounted) {
        final recognizedBlocks = ref.read(recognizedTextProvider);
        print(recognizedBlocks);
        for (var block in recognizedBlocks) {
          print(block.text);
        }
        // TODO: implemntar logica para ver si contiene alergenos o no
        final bool containsAllergens = true;
        final ResultsState resultsState = ResultsState(
          isAllergenFree: !containsAllergens,
          isUnrecognizedText: false,
        );
        GoRouter.of(context).goNamed("results_screen", extra: resultsState);
      }
    });
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Analizing Ingredients", style: CustomTextStyles.darkGrey400),
          SizedBox(height: 16),
          SizedBox(
            // Línea de progreso
            width: 175,
            child: LinearProgressIndicator(
              backgroundColor: Color(0xFFD9D9D9),
              color: CustomColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class Remainder extends StatelessWidget {
  const Remainder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 4.0, color: CustomColors.primary),
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          ),
          width: 350,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Text(
              "Remember that this app does not replace medical opinion.",
              style: CustomTextStyles.darkGrey400,
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}

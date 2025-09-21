import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class TransitionScreen extends StatelessWidget {
  static const String screenName = "transition_screen";
  const TransitionScreen({super.key});

  @override
  // TODO: Queda pendiente la transición a la página de resultados.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ProgressBar(), Remainder()],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Analizing Ingredients", style: CustomTextStyles.darkGrey400),
          const SizedBox(height: 16),
          SizedBox(
            // Línea de progreso
            width: 175,
            child: LinearProgressIndicator(
              backgroundColor: const Color(0xFFD9D9D9),
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
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Text(
              "Recuerda: esta app no\nreemplaza la opinión médica.",
              style: CustomTextStyles.darkGrey400,
            ),
          ),
        ),
      ),
    );
  }
}

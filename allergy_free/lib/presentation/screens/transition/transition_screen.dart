import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/config/utils/helpers/results_state.dart';
import 'package:allergy_free/database/database_operations.dart';
import 'package:allergy_free/models/allergy.dart';
import 'package:allergy_free/models/ingredient.dart';
import 'package:allergy_free/models/user.dart';
import 'package:allergy_free/presentation/providers/recognized_text_provider.dart';
import 'package:allergy_free/presentation/providers/user_provider.dart';
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
    Future.delayed(Duration(seconds: 7), () async {
      if (mounted) {
        final recognizedBlocks = ref.read(recognizedTextProvider);
        final String recognizedText = recognizedBlocks
            .map((block) => block.text)
            .toList()
            .join(' ');
        print("Texto: , $recognizedText");
        // Verificar alérgenos
        final bool containsAllergens = await _checkForAllergens(recognizedText);
        // Verificar si el texto está vacío
        final bool isUnrecognized = recognizedText.trim().isEmpty;
        // Navegar a la pantalla de resultados
        final ResultsState resultsState = ResultsState(
          isAllergenFree: !containsAllergens,
          isUnrecognizedText: isUnrecognized,
        );
        GoRouter.of(context).goNamed("results_screen", extra: resultsState);
      }
    });
  }

  Future<bool> _checkForAllergens(String recognizedText) async {
    final DatabaseOperations dbOps = DatabaseOperations();

    try {
      // Obtener el usuario
      final User? currentUser = ref.read(userProvider);

      if (currentUser == null) {
        print("Error, no hay usuario");
        return false;
      }

      print("Usuario actual: ${currentUser.username} (ID: ${currentUser.id})");

      // Obtener las alergias del usuario
      final List<Allergy> userAllergies = await dbOps.getUserAllergies(
        currentUser.id!,
      );

      if (userAllergies.isEmpty) {
        print("Error, no hay alergias");
        return false;
      }

      print(
        "Alergias del usuario: ${userAllergies.map((a) => a.allergyName).toList()}",
      );

      for (final allergy in userAllergies) {
        // Obtener ingredientes asociados a la alergia
        final List<Ingredient> allergyIngredients = await dbOps
            .getIngredientsForAllergy(allergy.id!);

        print("alergia actual: ${allergy.allergyName}");
        print(
          "Ingredientes relacionados: ${allergyIngredients.map((i) => i.name).toList()}",
        );

        // Verificar si el ingrediente está en el texto leído
        for (final ingredient in allergyIngredients) {
          if (_containsIngredient(recognizedText, ingredient.name)) {
            print("ALERGIA DETECTADA: ${allergy.allergyName}");
            print("Ingrediente: ${ingredient.name}");
            print("texto: $recognizedText");
            return true;
          }
        }
      }

      print("No se detectaron alérgenos");
      return false;
    } catch (e) {
      print("Error en _checkForAllergens: $e");
      return false;
    }
  }

  bool _containsIngredient(String recognizedText, String ingredientName) {
    // Normalizar texto
    final textLower = _normalizeText(recognizedText);
    final ingredientLower = _normalizeText(ingredientName);

    // print("Buscando: '$ingredientLower' en: '$textLower'");

    // Búsqueda exacta primero
    if (textLower.contains(ingredientLower)) {
      print("Coincidencia exacta encontrada");
      return true;
    }

    // Para ingredientes compuestos, buscar palabras clave
    // final ingredientWords =
    //     ingredientLower.split(' ').where((word) => word.length > 2).toList();

    // if (ingredientWords.length > 1) {
    //   int matches = 0;
    //   for (final word in ingredientWords) {
    //     if (textLower.contains(word)) {
    //       matches++;
    //     }
    //   }
    //   // Si la mayoría de las palabras coinciden
    //   if (matches >= ingredientWords.length ~/ 2 + 1) {
    //     print(
    //       "Coincidencia parcial($matches/${ingredientWords.length} palabras)",
    //     );
    //     return true;
    //   }
    // }

    return false;
  }

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
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

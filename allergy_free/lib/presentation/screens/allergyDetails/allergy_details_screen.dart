import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/database/database_operations.dart';
import 'package:allergy_free/models/allergy.dart';
import 'package:allergy_free/models/ingredient.dart';
import 'package:allergy_free/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ingredientsForAllergyProvider =
    FutureProvider.family<List<Ingredient>, int>((ref, allergyId) {
      return DatabaseOperations().getIngredientsForAllergy(allergyId);
    });

class AllergyDetailsScreen extends ConsumerWidget {
  static const String screenName = 'allergy_details';
  final Allergy allergy;

  const AllergyDetailsScreen({super.key, required this.allergy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Ingredient>> ingredients = ref.watch(
      ingredientsForAllergyProvider(allergy.id!),
    );
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: Appbar(),
      body: ingredients.when(
        data: (ingredientList) {
          if (ingredientList.isEmpty) {
            return const Center(
              child: Text(
                "There are no ingredients registered for this allergy.",
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Text('Ingredients', style: CustomTextStyles.title),
                Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.07),
                  child: Card(
                    color: CustomColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          allergy.allergyName,
                          style: CustomTextStyles.signaling,
                          textAlign: TextAlign.center,
                        ),

                        Padding(
                          padding: EdgeInsets.all(screenSize.width * 0.04),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenSize.width * 0.04),
                              child: ListView.builder(
                                itemCount: ingredientList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          ingredientList[index].name,
                                          style: CustomTextStyles.inputText,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      if (index < ingredientList.length - 1)
                                        Divider(
                                          height: 1,
                                          color: Colors.grey[300],
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error:
            (err, stack) => Center(
              child: Text("Error while loading the ingredients: $err"),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}

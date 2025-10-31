import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/models/allergy.dart';
import 'package:allergy_free/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// Widget que muestra un menú desplegable para seleccionar alérgenos.
class AllergenDropdownMenu extends ConsumerStatefulWidget {
  final double width;
  final double height;

  const AllergenDropdownMenu({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  ConsumerState<AllergenDropdownMenu> createState() =>
      _AllergenDropdownMenuState();
}

// Estado del widget AllergenDropdownMenu que maneja la lógica de selección de alérgenos.
class _AllergenDropdownMenuState extends ConsumerState<AllergenDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Allergy>> systemAllergies = ref.watch(
      systemAllergiesProvider,
    );
    final List<Allergy> selectedAllergens = ref.watch(
      selectedAllergensProvider,
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: InkWell(
                onTap:
                    systemAllergies.hasValue
                        ? () => _showMultiSelectDialog(
                          context,
                          systemAllergies.value!,
                        )
                        : null,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: CustomColors.primary, width: 4),
                  ),
                  child: systemAllergies.when(
                    data: (allergies) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              "Select allergens",
                              style: CustomTextStyles.greyedText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: CustomColors.greyLetters,
                            size: 30,
                          ),
                        ],
                      );
                    },
                    error: (err, stack) {
                      // Estado de error: Muestra un mensaje
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, color: Colors.red),
                          SizedBox(width: 16),
                          Text(
                            "Could not load allergens",
                            style: CustomTextStyles.greyedText,
                          ),
                        ],
                      );
                    },
                    loading: () {
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 16),
                          Text(
                            "Loading allergens...",
                            style: CustomTextStyles.greyedText,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: widget.width,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: -6,
              children:
                  selectedAllergens.map((allergen) {
                    return Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      label: Text(allergen.allergyName),
                      backgroundColor: CustomColors.primary,
                      deleteIconColor: Colors.white,
                      labelStyle: CustomTextStyles.whiteTextChip,
                      onDeleted: () {
                        final currentList = ref.read(selectedAllergensProvider);
                        ref.read(selectedAllergensProvider.notifier).state =
                            currentList
                                .where(
                                  (item) =>
                                      item.allergyName != allergen.allergyName,
                                )
                                .toList();
                      },
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Función para mostrar diálogo de entrada de texto para agregar un alérgeno personalizado.
  Future<String?> _showCustomAllergenDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add allergen', style: CustomTextStyles.greyedText),
          content: SizedBox(
            width: widget.width,
            height: widget.height,
            child: TextField(
              controller: controller,
              autofocus: true,
              style: CustomTextStyles.inputText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                hintText: "Allergen name",
                hintStyle: CustomTextStyles.greyedText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: CustomColors.primary,
                    width: 3.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: CustomColors.focus,
                    width: 4.0,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: CustomColors.primary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text(
                'OK',
                style: TextStyle(color: CustomColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  //Dialogo de selección múltiple
  void _showMultiSelectDialog(BuildContext context, List<Allergy> allergyList) {
    final selectedAllergens = ref.read(selectedAllergensProvider);
    final List<MultiSelectItem<Object>> items =
        allergyList
            .map(
              (allergy) => MultiSelectItem<Object>(
                allergy, // El valor es el objeto Allergy completo
                allergy.allergyName
              ),
            )
            .toList();
    items.add(MultiSelectItem<String>('Other (specify)', 'Other (specify)'));
    showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: items,
          initialValue: selectedAllergens,
          title: Flexible(
            child: Text(
              "Select your allergens",
              style: CustomTextStyles.greyedText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          searchable: true,
          searchIcon: const Icon(Icons.search, color: CustomColors.greyLetters),
          selectedColor: CustomColors.primary,
          checkColor: Colors.white,
          onConfirm: (values) async {
            final List<Allergy> newSelected = [];

            for (final item in values) {
              if (item is Allergy) {
                newSelected.add(item);
              }

              if (item is String && item == 'Other (specify)') {
                String? customAllergen = await _showCustomAllergenDialog(
                  context,
                );

                if (customAllergen != null && customAllergen.isNotEmpty) {
                  String customAllergenNormalized =
                      customAllergen[0].toUpperCase() +
                      customAllergen.substring(1).toLowerCase();

                  final tempAllergy = Allergy(
                    id: null,
                    allergyName: customAllergenNormalized,
                    description: "Custom allergen",
                  );

                  if (!newSelected.any(
                    (a) => a.allergyName == tempAllergy.allergyName,
                  )) {
                    newSelected.add(tempAllergy);
                  }
                }
              }
            }
            ref.read(selectedAllergensProvider.notifier).state = newSelected;
          },
        );
      },
    );
  }
}

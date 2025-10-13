import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:allergy_free/presentation/providers/selected_allergens_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  ConsumerState<AllergenDropdownMenu> createState() => _AllergenDropdownMenuState();
}

// Estado del widget AllergenDropdownMenu que maneja la lógica de selección de alérgenos.
class _AllergenDropdownMenuState extends ConsumerState<AllergenDropdownMenu> {
  // Lista de alérgenos disponibles para seleccionar.
  final List<String> allergenList = [
    'Almond',
    'Celery',
    'Peanut',
    'Chocolate',
    'Strawberry',
    'Gluten',
    'Egg',
    'Kiwi',
    'Milk',
    'Apple',
    'Shellfish',
    'Walnut',
    'Cashew',
    'Fish',
    'Pistachio',
    'Sesame',
    'Soy',
    'Tomato',
    'Wheat',
    'Other (specify)',
  ];

  // Lista para almacenar los alérgenos seleccionados por el usuario.
  // List<String> selectedAllergens = [];

  @override
  Widget build(BuildContext context) {
    final List<String> selectedAllergens = ref.watch(selectedAllergensProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: InkWell(
                onTap: () => _showMultiSelectDialog(context),
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: CustomColors.primary, width: 4),
                  ),
                  child: Row(
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
                      label: Text(allergen),
                      backgroundColor: CustomColors.primary,
                      deleteIconColor: Colors.white,
                      labelStyle: CustomTextStyles.whiteTextChip,
                      onDeleted: () {
                        final currentList = ref.read(selectedAllergensProvider);
                        ref.read(selectedAllergensProvider.notifier).state = [
                          for (final item in currentList)
                            if (item != allergen) item,
                        ];
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
  void _showMultiSelectDialog(BuildContext context) {
    final selectedAllergens = ref.read(selectedAllergensProvider);
    showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items:
              allergenList
                  .map(
                    (alergeno) => MultiSelectItem<String>(alergeno, alergeno),
                  )
                  .toList(),
          initialValue: selectedAllergens,
          title: Text(
            "Select your allergens",
            style: CustomTextStyles.greyedText,
          ),
          searchable: true,
          searchIcon: const Icon(Icons.search, color: CustomColors.greyLetters),
          selectedColor: CustomColors.primary,
          checkColor: Colors.white,
          onConfirm: (values) async {
            List<String> newSelected = List.from(values.cast<String>());

            // Verificar si seleccionó "Otro"
            if (newSelected.contains('Other (specify)')) {
              // Remover opción temporal
              newSelected.remove('Other (specify)');

              // Mostrar diálogo personalizado
              String? customAllergen = await _showCustomAllergenDialog(context);

              //Verificar si se ingresó un alérgeno personalizado
              if (customAllergen != null && customAllergen.isNotEmpty) {
                String customAllergenNormalized =
                    customAllergen[0].toUpperCase() +
                    customAllergen.substring(1).toLowerCase();

                // Agrega el alergeno personalizado a la lista
                if (!newSelected.contains(customAllergenNormalized)) {
                  newSelected.add(customAllergenNormalized);
                }
              }
            }
            // Actualizar estado
            ref.read(selectedAllergensProvider.notifier).state = newSelected;
            print(selectedAllergens);
            // setState(() => selectedAllergens = newSelected);
          },
        );
      },
    );
  }
}

import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AllergenDropdownMenu extends StatefulWidget {
  final double width;
  final double height;

  const AllergenDropdownMenu({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<AllergenDropdownMenu> createState() => _AllergenDropdownMenuState();
}

//Lista de alergenos
class _AllergenDropdownMenuState extends State<AllergenDropdownMenu> {
  final List<String> listaAlergenos = [
    'Almendra',
    'Apio',
    'Cacahuate',
    'Chocolate',
    'Fresa',
    'Gluten',
    'Huevo',
    'Kiwi',
    'Leche',
    'Manzana',
    'Mariscos',
    'Nuez',
    'Nuez de la India',
    'Pescado',
    'Pistache',
    'Sésamo/Ajonjolí',
    'Soja',
    'Tomate',
    'Trigo',
  ];

  List<String> selectedAllergens = [];

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: InkWell(
                onTap: () => _showMultiSelectDialog(context),
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: CustomColors.primary, width: 3),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cambio clave: Expanded para el texto
                      Expanded(
                        child: Text(
                          "Selecciona uno o más alérgenos",
                          style: CustomTextStyles.greyedText,
                          overflow: TextOverflow.ellipsis, // Puntos suspensivos si no cabe
                          maxLines: 1, // Mantener en una sola línea
                        ),
                      ),
                      const SizedBox(width: 8), // Espacio entre texto e ícono
                      Icon(
                        Icons.arrow_drop_down,
                        color: CustomColors.greyLetters,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedAllergens.map((allergen) {
                return Chip(
                  label: Text(allergen),
                  backgroundColor: CustomColors.primary,
                  deleteIconColor: Colors.white,
                  onDeleted: () {
                    setState(() {
                      selectedAllergens.remove(allergen);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}

void _showMultiSelectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return MultiSelectDialog(
        items: listaAlergenos
            .map((alergeno) => MultiSelectItem<String>(alergeno, alergeno))
            .toList(),
        initialValue: selectedAllergens,
        title: const Text("Selecciona alérgenos", style: CustomTextStyles.greyedText),
        searchable: true,
        selectedColor: CustomColors.primary,
        checkColor: Colors.white,
        onConfirm: (values) {
          setState(() {
            selectedAllergens = values.cast<String>();
          });
        },
      );
    },
  );
}}
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
  
            //Botón de selección
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: InkWell(
                //funcionalidad
                onTap: () => _showMultiSelectDialog(context), // Muestra el diálogo de selección
                //Estilo del botón
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
                      Expanded(
                        child: Text(
                          "Seleccionar alérgenos",
                          style: CustomTextStyles.greyedText,
                          overflow: TextOverflow.ellipsis, // Evitar overflow si el texto no cabe
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

            //Visualización de alérgenos seleccionados (Chips)
            Wrap(
              spacing: 6,
              runSpacing: -4,
              children: selectedAllergens.map((allergen) {
                return Chip(
                  shape: RoundedRectangleBorder( // Propiedad para redondear
                    borderRadius: BorderRadius.circular(50), // Radio personalizado
                  ),
                  label: Text(allergen),
                  backgroundColor: CustomColors.primary,
                  deleteIconColor: Colors.white,
                  labelStyle: CustomTextStyles.whiteTextChip,
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

//Dialogo de selección múltiple
void _showMultiSelectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return MultiSelectDialog(
        items: listaAlergenos
            .map((alergeno) => MultiSelectItem<String>(alergeno, alergeno))
            .toList(),
        initialValue: selectedAllergens, // Valores seleccionados inicialmente
        title: const Text("Selecciona alérgenos", style: CustomTextStyles.greyedText),
        searchable: true,
        searchIcon: Icon(Icons.search, color: CustomColors.greyLetters),
        selectedColor: CustomColors.primary,
        checkColor: Colors.white,
        onConfirm: (values) {
          setState(() {
            selectedAllergens = values.cast<String>(); // Actualiza la lista de alérgenos seleccionados
          });
        },
      );
    },
  );
}}
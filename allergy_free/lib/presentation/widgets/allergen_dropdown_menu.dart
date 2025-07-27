import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AllergenDropdownMenu extends StatefulWidget {
  const AllergenDropdownMenu({super.key});

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
          child: MultiSelectDialogField(
            items: listaAlergenos.map((alergeno) => MultiSelectItem<String>(alergeno, alergeno)).toList(), //Convertir la lista de alérgenos a MultiSelectItem
            title: const Text("Selecciona alérgenos", style: CustomTextStyles.greyedText), //Titulo del dialogo de seleccion
            buttonText: const Text("Selecciona uno o más alérgenos", style: CustomTextStyles.greyedText, overflow: TextOverflow.ellipsis), //Texto que aparece en el botón antes de seleccionar
            searchable: true,
            searchIcon: Icon(Icons.search, color: CustomColors.greyLetters),
            buttonIcon: Icon(Icons.arrow_drop_down, color: CustomColors.greyLetters, size: 30),
            selectedColor: CustomColors.primary,
            checkColor: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: CustomColors.primary, width: 3),
            ),
            onConfirm: (values) {
              setState(() {
                selectedAllergens = values.cast<String>();
              });
            },
            chipDisplay: MultiSelectChipDisplay(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              textStyle: const TextStyle(color: Color.fromRGBO(74, 68, 88, 35)),
              onTap: (item) {
                setState(() {
                  selectedAllergens.remove(item);
                });
              },
            ),       
          ),
        ),
      ),
    );
  }
}


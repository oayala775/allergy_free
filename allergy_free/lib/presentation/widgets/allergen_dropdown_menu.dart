import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
//TODO: Ancho y alto por parametro
class AllergenDropdownMenu extends StatefulWidget {
  const AllergenDropdownMenu({super.key});

  @override
  State<AllergenDropdownMenu> createState() => _AllergenDropdownMenuState();
}

class _AllergenDropdownMenuState extends State<AllergenDropdownMenu> {
    final List<String> allergenList = [
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
    String? selectedAllergen;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: DropdownMenu<String>(
                    label: const Text('Selecciona un alérgeno'),
                    initialSelection: selectedAllergen,
                    hintText: 'Selecciona un alérgeno',
                    dropdownMenuEntries: allergenList.map((String allergen) {
                        return DropdownMenuEntry<String>(
                            value: allergen,
                            label: allergen,
                        );
                    },
                    ).toList(),
                    onSelected: (String? value) {
                        setState(() {
                            selectedAllergen = value;
                        });
                    },
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder( // Borde redondeado
                        borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder( // Borde cuando está habilitado
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 174, 40, 40)),
                        ),
                        focusedBorder: OutlineInputBorder( // Borde cuando está seleccionado
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: CustomColors.focus),
                        ),
                    ),
                    menuStyle: MenuStyle(
                        shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                        ),
                        ),
                    ),
                ),
            ),
        );
    }
}
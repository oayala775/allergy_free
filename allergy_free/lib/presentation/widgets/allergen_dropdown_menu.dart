import 'package:allergy_free/config/utils/custom_colors.dart';
import 'package:allergy_free/config/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// Widget que muestra un menú desplegable para seleccionar alérgenos.
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

// Estado del widget AllergenDropdownMenu que maneja la lógica de selección de alérgenos.
class _AllergenDropdownMenuState extends State<AllergenDropdownMenu> {

  // Lista de alérgenos disponibles para seleccionar.
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
    'Otro (escribir)',
  ];

  // Lista para almacenar los alérgenos seleccionados por el usuario.
  List<String> selectedAllergens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16), 
          child: Column(
            children: [
              Center(child: 
              // Botón que al hacer clic muestra un diálogo para seleccionar alérgenos
              SizedBox(
                // Ancho y alto del botón
                width: widget.width,
                height: widget.height,
                child: InkWell(
                  //funcionalidad
                  onTap: () => _showMultiSelectDialog(context), // Muestra el diálogo de selección
                  //Estilo del botón
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: CustomColors.primary, width: 3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        const SizedBox(width: 8), // Espacio entre texto e ícono
                        Expanded(
                          child: Text(
                            "Seleccionar alérgenos",
                            style: CustomTextStyles.greyedText,
                            overflow: TextOverflow.ellipsis, // Evitar overflow si el texto no cabe
                            maxLines: 1, // Mantener en una sola línea
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: CustomColors.greyLetters, size: 30),
                      ],
                    ),
                  ),
                ),
              ),
              ),

              //Visualización de alérgenos seleccionados (Chips)
              SizedBox(
                width: widget.width,
                child: Wrap(
                  alignment: WrapAlignment.center, 
                  spacing: 6, //Espaciado vertical entre chips
                  runSpacing: -6, // Espaciado horizontal entre chips
                  children: selectedAllergens.map((allergen) {
                    return Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      label: Text(allergen),
                      backgroundColor: CustomColors.primary,
                      deleteIconColor: Colors.white,
                      labelStyle: CustomTextStyles.whiteTextChip,
                      // Funcionalidad para eliminar alérgeno seleccionado
                      onDeleted: () {
                        setState(() {
                          selectedAllergens.remove(allergen);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
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
          title: Text('Agregar alérgeno', style: CustomTextStyles.greyedText),
          content: SizedBox(
            width: widget.width,
            height: widget.height,
            child:
              TextField(
                controller: controller,
                autofocus: true,
                style: CustomTextStyles.inputText,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  hintText: "Nombre del alérgeno",
                  hintStyle: CustomTextStyles.greyedText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: CustomColors.primary, width: 3.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: CustomColors.focus, width: 3.0),
                  ),
                ),
              ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('CANCEL', style: TextStyle(color: CustomColors.primary)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: Text('OK', style: TextStyle(color: CustomColors.primary)),
            ),
          ],
        );
      },
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
          initialValue: selectedAllergens,
          title: const Text("Selecciona alérgenos", style: CustomTextStyles.greyedText),
          searchable: true,
          searchIcon: Icon(Icons.search, color: CustomColors.greyLetters),
          selectedColor: CustomColors.primary,
          checkColor: Colors.white,
          onConfirm: (values) async {
            List<String> newSelected = List.from(values.cast<String>());
            
            // Verificar si seleccionó "Otro"
            if (newSelected.contains('Otro (escribir)')) {
              // Remover opción temporal
              newSelected.remove('Otro (escribir)');
              
              // Mostrar diálogo personalizado
              String? customAllergen = await _showCustomAllergenDialog(context);
              
              //Verificar si se ingresó un alérgeno personalizado
              if (customAllergen != null && customAllergen.isNotEmpty) {

                String customAllergenNormalized = customAllergen[0].toUpperCase() + customAllergen.substring(1).toLowerCase();
                
                // Agrega el alergeno personalizado a la lista
                if (!newSelected.contains(customAllergenNormalized)) {
                  newSelected.add(customAllergenNormalized);
                }
              }
            }
            // Actualizar estado
            setState(() => selectedAllergens = newSelected);
          },
        );
      },
    );
  }
}